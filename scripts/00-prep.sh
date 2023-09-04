#!/bin/bash

if [ $# -eq 0 ]; then
    echo "You must add your bitwarden username as a parameter"
    echo "E.g ./00-prep.sh bitwarden@user.name"
    exit 1
fi

set -euxo pipefail

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

$script_dir/01-install-dependencies.sh
$script_dir/02-add-user-no-pwd-sudo.sh
$script_dir/03-add-home-local-bin.sh
$script_dir/04-get-bitwarden-secrets.sh $1
