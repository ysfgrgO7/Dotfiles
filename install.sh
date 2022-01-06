#!/usr/bin/env bash
cd 
git clone https://github.com/ysfgrgO7/Dotfiles.git
mkdir -p ~/.config
cd ~/.config/
cp -r ~/Dotfiles/.xprofile ~/.xprofile
cp -r ~/Dotfiles/.config/alacritty ~/.config/alacritty
cp -r ~/Dotfiles/.config/doom ~/.config/doom
cp -r ~/Dotfiles/.config/picom ~/.config/picom
cp -r ~/Dotfiles/.config/ranger ~/.config/ranger
cp -r ~/Dotfiles/.config/rofi ~/.config/rofi
cp -r ~/Dotfiles/.config/VSCodium ~/.config/VSCodium
cp -r ~/Dotfiles/.config/zsh ~/.config/zsh
cp -r ~/Dotfiles/.local/share/bin/ ~/.local/share/bin
