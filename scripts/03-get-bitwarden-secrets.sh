#!/bin/bash

set -euo pipefail

if ! command -v bw &> /dev/null; then
  echo -e "\nBW CLI not installed.\nInstall with: sudo snap install bitwarden"
  exit 1
fi

if [[ "$(bw status)" == *"unlocked"* ]]; then
  echo -e "Bitwarden unlocked via BW_SESSION env var"
elif [[ "$(bw status)" == *"unauthenticated"* ]]; then
  export BW_SESSION="$(bw login --raw)"
else
  export BW_SESSION="$(bw unlock --raw)"
fi

echo -e "\nGetting SSH Keys"

while IFS= read -r secret_name; do
  echo "Getting $secret_name"
  ssh-manager get --name "$secret_name" --provider bw
done <<< "$(bw get notes ssh_key_list)"

cp $HOME/.ssh/keys/* $HOME/.ssh

echo -e "\nFinished"