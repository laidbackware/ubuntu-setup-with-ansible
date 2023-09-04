#!/bin/bash

echo -e "\nInstalling apt packages"
sudo apt install curl python3-pip python-is-python3 vim software-properties-common

echo -e "\nInstalling Ansible"
sudo rm -rf /usr/lib/python3.*/EXTERNALLY-MANAGED
pip3 install ansible

echo -e "\nInstalling bitwarden cli"
sudo snap install bw

echo -e "\nInstalling ssh-manager"
if ! command -v ssh-manager &> /dev/null; then
    sudo curl -fL https://github.com/omegion/ssh-manager/releases/download/v1.2.0/ssh-manager-linux-amd64 -o /usr/local/bin/ssh-manager \
    && sudo chmod +x /usr/local/bin/ssh-manager
fi