#!/bin/bash

set -euxo pipefail

sudoers_string="${USER} ALL=(ALL) NOPASSWD: ALL"
if ! sudo grep -Fxq "$sudoers_string" /etc/sudoers
then
    sudo chmod 640 /etc/sudoers
    echo $sudoers_string | sudo tee -a /etc/sudoers
    sudo chmod 440 /etc/sudoers
fi