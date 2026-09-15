#!/bin/bash

if ! command -v pacman &>/dev/null; then
    echo "This script requires an Arch-based system (pacman not found)."
    exit 1
fi

# Basic Setup
clear
if [ "$(id -u)" = 0 ]; then
	echo "##################################################################"
	echo "This script MUST NOT be run as root user since it makes changes"
	echo "to the \$HOME directory of the \$USER executing this script."
	echo "The \$HOME directory of the root user is, of course, '/root'."
	echo "We don't want to mess around in there. So run this script as a"
	echo "normal user. You will be asked for a sudo password when necessary."
	echo "##################################################################"
	exit 1
fi
clear
cp -r ~/.config ~/.config_backup_$(date +%s)

# Fonts
clear
while true; do
  read -p "Would you like to install nerd fonts? (y/n) " answer
  case $answer in
    y|Y)
	curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
	mkdir newfont
	mv JetBrainsMono.tar.xz newfont
	cd newfont
	tar xf JetBrainsMono.tar.xz
	cd ../
	sudo cp -r newfont/* /usr/share/fonts/
	sudo fc-cache -fv
	break
      ;;
    n|N)
      echo "Installation cancelled."
      exit 0
      ;;
    *)
      echo "Please answer with 'y' or 'n'."
      ;;
  esac
done

# Install Paru
echo "Installing Paru"
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# Install Dependencies
sudo pacman -Syu --noconfirm --needed base-devel cmake fd ripgrep git zsh fzf exa alacritty kitty neovim python-pip python-pynvim nodejs npm yarn yazi lua lua51

# Dotfiles
cp -r ./linux/zshrc ~/.zshrc
cp -r ./linux/alacritty ~/.config/alacritty
cp -r ./linux/kitty ~/.config/kitty

# Lfetch
cp -r ./linux/lfetch ~/.local/share/lfetch
cd ~/.local/share/lfetch
sudo make install || exit

while true; do
	read -p "Do you want to reboot? [Y/n] " yn
	case $yn in
	[Yy]*) reboot ;;
	[Nn]*) break ;;
	"") reboot ;;
	*) echo "Please answer yes or no." ;;
	esac
done
