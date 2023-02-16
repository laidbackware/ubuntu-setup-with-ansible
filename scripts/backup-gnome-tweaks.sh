#!/bin/bash
set -eu
# Utility to backup current Gnome tweaks
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

function dump() {
  name="$1"
  path="$2"
  role="$3"

  echo "dumping $name config"
  dconf dump "$path" > "${script_dir}/../roles/gnome/${role}/files/${name}.conf"
}

dump "desktop" "/org/gnome/desktop/interface/" "theme"
dump "user-theme" "/org/gnome/shell/extensions/user-theme/" "theme"

dump "dash-to-panel" "/org/gnome/shell/extensions/dash-to-panel/" "settings"
dump "mouse" "/org/gnome/desktop/peripherals/mouse/" "settings"
dump "touchpad" "/org/gnome/desktop/peripherals/touchpad/" "settings"
dump "key-bind-0" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "settings"
dump "power" "/org/gnome/settings-daemon/plugins/power/" "settings"