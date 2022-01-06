#!/bin/bash

config="$HOME/.config/alacritty/alacritty.yml"

declare -a options=(
"doom-one"
"dracula"
"gruvbox-dark"
"monokai-pro"
"nord"
"oceanic-next"
"solarized-light"
"solarized-dark"
"tomorrow-night"
"quit"
)

choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -l 20 -p 'Themes')

if [[ "$choice" == quit ]]; then
    echo "No Theme Chosen" && exit 1
elif [[ "$choice" == 'doom-one' ]]; then
    sed -i '/colors:/c\colors: *doom-one' $config
elif [[ "$choice" == 'dracula' ]]; then
    sed -i '/colors:/c\colors: *dracula' $config
elif [[ "$choice" == 'gruvbox-dark' ]]; then
    sed -i '/colors:/c\colors: *gruvbox-dark' $config
elif [[ "$choice" == 'monokai-pro' ]]; then
    sed -i '/colors:/c\colors: *monokai-pro' $config
elif [[ "$choice" == 'nord' ]]; then
    sed -i '/colors:/c\colors: *nord' $config
elif [[ "$choice" == 'oceanic-next' ]]; then
    sed -i '/colors:/c\colors: *oceanic-next' $config
elif [[ "$choice" == 'solarized-light' ]]; then
    sed -i '/colors:/c\colors: *solarized-light' $config
elif [[ "$choice" == 'solarized-dark' ]]; then
    sed -i '/colors:/c\colors: *solarized-dark' $config
elif [[ "$choice" == 'tomorrow-night' ]]; then
    sed -i '/colors:/c\colors: *tomorrow-night' $config
fi


