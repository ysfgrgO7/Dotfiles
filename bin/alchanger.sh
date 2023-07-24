#!/bin/bash

config="$HOME/.config/alacritty/alacritty.yml"

declare -a options=(
  "darkplus"
  "doom-one"
  "dracula"
  "nord"
  "tokyonight"
  "onedark"
  "quit"
)

choice=$(printf '%s\n' "${options[@]}" | dmenu -c -i -l 20 -p 'Themes')

if [[ "$choice" == quit ]]; then
    echo "No Theme Chosen" && exit 1
elif [[ "$choice" == 'doom-one' ]]; then
    sed -i '/colors:/c\colors: *doom-one' $config
elif [[ "$choice" == 'dracula' ]]; then
    sed -i '/colors:/c\colors: *dracula' $config
elif [[ "$choice" == 'nord' ]]; then
    sed -i '/colors:/c\colors: *nord' $config
elif [[ "$choice" == 'darkplus' ]]; then
    sed -i '/colors:/c\colors: *darkplus' $config
elif [[ "$choice" == 'tokyonight' ]]; then
    sed -i '/colors:/c\colors: *tokyonight' $config
elif [[ "$choice" == 'onedark' ]]; then
    sed -i '/colors:/c\colors: *onedark' $config
fi


