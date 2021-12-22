function sshp() {
  target=$1
  if [ -z $target ]; then
    >&2 echo "You must pass in a param. E.g. sshp root@1.2.3.4"
  fi
  ssh ${target} -o PreferredAuthentications=password -o PubkeyAuthentication=no
}