#!/usr/bin/env bash

# =========================================
# Arch Linux Post-Install Script
# Ryzen 8845HS + Radeon 780M
# Minimal GNOME + Hyprland Setup
# =========================================

set -e

echo "==============================="
echo "Updating system..."
echo "==============================="
sudo pacman -Syu --noconfirm

echo "==============================="
echo "Installing core system packages..."
echo "==============================="

sudo pacman -S --needed --noconfirm \
    linux-zen \
    linux-zen-headers \
    amd-ucode \
    mesa \
    vulkan-radeon \
    lib32-mesa \
    pipewire \
    pipewire-pulse \
    pipewire-alsa \
    wireplumber \
    xdg-desktop-portal \
    xdg-desktop-portal-gtk \
    xdg-desktop-portal-hyprland \
    power-profiles-daemon \
    thermald \
    networkmanager \
    bluez \
    bluez-utils \
    brightnessctl \
    playerctl \
    pavucontrol \
    wl-clipboard \
    cliphist \
    grim \
    slurp \
    kitty \
    unzip \
    zip \
    unrar \
    wget \
    curl \
    git \
    neovim \
    thunar \
    gvfs \
    tumbler \
    polkit-gnome \
    qt5-wayland \
    qt6-wayland \
    hyprland \
    hyprpaper \
    hyprlock \
    waybar \
    rofi \
    rofi-wayland \
    mako \
    gnome-shell \
    gdm \
    gnome-control-center \
    gnome-settings-daemon \
    gnome-session \
    nautilus \
    gnome-keyring \
    gnome-tweaks \
    adwaita-icon-theme \
    xdg-user-dirs-gtk \
    ttf-jetbrains-mono-nerd \
    noto-fonts \
    noto-fonts-emoji

echo "==============================="
echo "Enabling services..."
echo "==============================="

sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
sudo systemctl enable gdm
sudo systemctl enable power-profiles-daemon

echo "==============================="
echo "Configuring Electron Wayland..."
echo "==============================="

mkdir -p ~/.config

cat > ~/.config/electron-flags.conf <<EOF
--enable-features=UseOzonePlatform
--ozone-platform=wayland
EOF

echo "==============================="
echo "Setting environment variables..."
echo "==============================="

if ! grep -q "NIXOS_OZONE_WL=1" ~/.profile 2>/dev/null; then
cat >> ~/.profile <<EOF

# Wayland
export NIXOS_OZONE_WL=1
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export SDL_VIDEODRIVER=wayland
EOF
fi

echo "==============================="
echo "Done!"
echo "Reboot recommended."
echo "==============================="
