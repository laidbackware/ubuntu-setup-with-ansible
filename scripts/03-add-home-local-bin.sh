#!/bin/bash

set -euxo pipefail

mkdir -p /home/$USER/.local/bin

path_string="/home/${USER}/.local/bin"
if ! sudo grep -Fxq "$path_string" /home/${USER}/.bashrc; then
    echo "${PATH}:${path_string}" >> /home/${USER}/.bashrc
    echo "You must create a new shell to have $HOME/.local/bin added to your path"
fi
