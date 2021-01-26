#!/bin/bash

if [ $# -eq 0 ]; then
    echo "You must add your lastpass username as a parameter"
    echo "E.g ./02-get-ssh-keys-from-lastpass.sh lastpass@user.name"
    exit 1
fi

set -euxo pipefail

if ! command -v lpass &> /dev/null
then
    echo "lpass CLI not found. Attempting to install"
    sudo apt install lastpass-cli
fi

if ! command -v lpass sync &> /dev/null
then
    lpass_username=$1
    lpass login $lpass_username
fi

mkdir -p $HOME/.ssh
lpass show git_key --field="Private Key" > $HOME/.ssh/git_key
lpass show git_key --field="Public Key" > $HOME/.ssh/git_key.pub