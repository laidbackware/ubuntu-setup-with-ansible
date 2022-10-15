function sshp() {
  target=$1
  if [ -z $target ]; then
    >&2 echo "You must pass in a param. E.g. sshp root@1.2.3.4"
  fi
  ssh ${target} -o PreferredAuthentications=password -o PubkeyAuthentication=no
}

function asdfu() {
  product_name=${1:-}
  if [ -z $product_name ]; then
    >&2 echo "You must pass in a product name. E.g. asdfu kubectl"
    return 1
  fi

  asdf plugin add $product_name
  ret_code=$?
  if [ $ret_code -eq 2 ]; then
    asdf plugin update $product_name || return 1
  elif [ $ret_code -ne 2 ] && [ $ret_code -ne 0 ]; then
    >&2 echo "ERROR: Aborting"
    return 1
  fi

  asdf install $product_name latest
  if [ $? -ne 0 ]; then
    >&2 echo "ERROR: Aborting"
    return 1
  fi

  latest_version="$(asdf list $product_name | sort -r | head -n 1 | xargs)" || return 1
  echo "Setting ${latest_version} as global default for ${product_name}"
  asdf global $product_name $latest_version
}

function labon() {
  ipmitool -H $IPMI_IP -U $IPMI_USERNAME -P $IMPI_PASSWORD power on
}

function suspend_vm() {
  vm_path=$1
  [ -z "${vm_path:-}" ] && echo 'A VM name must be passed as a parameter' && return 1

  # TODO handle VM not existing!
  if [[ "$(govc vm.info ${vm_path})" == *"poweredOn"* ]]; then
    echo -e "Suspending the VM ${vm_path}\n"
    govc vm.power -suspend -wait "${vm_path}"
  else
    echo -e "VM ${vm_path} is not powered on\n"
  fi
}

function laboff() {
  # Ensure correct vars are set and error if not
  export GOVC_URL=${GOVC_URL:-'192.168.1.251'}
  [ -z "${GOVC_USERNAME:-}" ] && echo '$GOVC_USERNAME must be set' && return 1
  [ -z "${GOVC_PASSWORD:-}" ] && echo '$GOVC_PASSWORD must be set' && return 1
  export GOVC_INSECURE=true
  
  if $(curl -k --output /dev/null --silent --head --fail -m 1 https://${GOVC_URL}); then
    echo -e "Host ${GOVC_URL} is online. Shutting down\n"
  else
    echo "Host is already offline"
    return 0
  fi

  # Suspect vCenter first to ensure vCLS doesn't get re-created
  suspend_vm "/ha-datacenter/vm/vcsa7"
  # Suspect untangle router
  suspend_vm "/ha-datacenter/vm/untangle"

  local vms=$(govc ls /ha-datacenter/vm)

  # Power off vCLS VMs
  local vcls_vms=$(echo "$vms" |grep "vCLS")
  for vm in "${vcls_vms}"; do
    local vcls_vm_state="$(govc vm.info ${vm})"
    local vm_name=$(echo "${vcls_vm_state}" |grep -i "Name:           " |sed s'/Name:           //')
    if [[ "${vcls_vm_state}" == *"poweredOn"* ]]; then
      echo -e "Terminating vCLS VM ${vm_name}"
      govc vm.power -off -wait $(echo "${vcls_vm_state}" |grep -i "Path:         " |sed s'/  Path:         //')
    else
      echo -e "vCLS VM ${vm_name} already powered off"
    fi
  done

  # Shuddown VMs
  local vms_to_power_off=""
  for vm in $vms; do
    local vm_state=$(govc vm.info "${vm}")
    if [[ "${vm_state}" == *"poweredOn"* ]]; then
      vms_to_power_off="${vms_to_power_off} $(echo "${vm_state}" |grep -i "Path:         " | sed s'/  Path:         //')"
    fi
  done
  if [ ! -z "${vms_to_power_off}" ]; then
    local vms_to_power_off_names=$(echo "${vms_to_power_off}" | sed  s'/\/ha-datacenter\/vm\///'g)
    echo -e "\nSuspending VMs:\n ${vms_to_power_off_names}\n"
    govc vm.power -s -wait $vms_to_power_off
  else
    echo -e "\nNo VMs to suspend"
  fi

  # Shutdown hosts
  hosts="$(govc ls /ha-datacenter/host)"
  for host in $hosts; do
    if ! govc host.info $host |grep -i "Maintenance Mode"; then
      govc host.maintenance.enter  $host
    else
      echo "Host ${host} is already in maintenance mode"
    fi
    govc host.shutdown "${host}"
  done
}
