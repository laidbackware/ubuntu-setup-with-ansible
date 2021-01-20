#!/bin/bash
# Utility to backup current Gnome tweaks
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
dconf dump / > ${script_dir}/../roles/gnome/tweaks/files/saved_settings.dconf