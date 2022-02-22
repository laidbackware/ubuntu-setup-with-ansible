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