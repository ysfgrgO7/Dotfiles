#!/usr/bin/env bash
cd 
mkdir -p ~/.config
cd ~/.config/
cp -r ~/Dotfiles/.xprofile ~/.xprofile
cp -r ~/Dotfiles/.config/alacritty ~/.config/alacritty
cp -r ~/Dotfiles/.config/kitty ~/.config/kitty
cp -r ~/Dotfiles/.config/picom ~/.config/picom
cp -r ~/Dotfiles/.config/ranger ~/.config/ranger
cp -r ~/Dotfiles/.config/rofi ~/.config/rofi
cp -r ~/Dotfiles/.config/zsh ~/.config/zsh
cp -r ~/Dotfiles/.config/user-dirs.dirs ~/.config/user-dirs.dirs
cp -r ~/Dotfiles/.local/share/bin/ ~/.local/share/bin

mkdir ~/Media
mv ~/Downloads ~/Media/dl
mv ~/Documents ~/Media/doc
mv ~/Music ~/Media/mus
mv ~/Pictures ~/Media/pic
mv ~/Videos ~/Media/vid
mv ~/Templates ~/.local
mv ~/Public ~/.local
