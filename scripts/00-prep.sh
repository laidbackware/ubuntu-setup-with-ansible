#!/bin/bash

if [ $# -eq 0 ]; then
    echo "You must add your lastpass username as a parameter"
    echo "E.g ./00-prep.sh lastpass@user.name"
    exit 1
fi

set -euxo pipefail

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

$script_dir/01-add-user-no-pwd-sudo.sh
$script_dir/02-get-ssh-keys-from-lastpass.sh $1
