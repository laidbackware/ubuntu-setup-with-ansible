#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cp ${HOME}/.local/share/arcmenu/stylesheet.css \
  ${script_dir}/../roles/gnome/extensions/files/arcmenu@arcmenu.com.css

cp ${HOME}/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/dash-to-panel-stylesheet.css \
  ${script_dir}/../roles/gnome/extensions/files/dash-to-panel@jderose9.github.com.css