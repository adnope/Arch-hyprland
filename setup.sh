#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Shell
sudo pacman -Syu zsh stow
sudo chsh -s /usr/bin/zsh

# Yay
sudo pacman -S --needed base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
cd $SCRIPT_DIR

# Main programs
sudo pacman -S dunst fastfetch swaybg hyprpicker hyprpaper hyprlock hyprsunset kitty micro rofi-wayland rofi-calc starship waybar nemo nemo-fileroller spotify-launcher cliphist brightnessctl playerctl grim slurp swappy ark fzf zoxide eza bat guvcview nwg-look

# System packages / Dependencies
sudo pacman -S imagemagick blueman bluez ffmpegthumbnailer polkit-kde-agent kwallet kwallet-pam libheif libpulse libraw linux-headers linux-zen-headers network-manager-applet os-prober pavucontrol jq man tldr wtype

# Yay packages
yay -S input-remapper-git visual-studio-code-bin zen-browser-bin

# Vietnamese input method
sudo pacman -S fcitx5 fcitx5-bamboo fcitx5-configtool fcitx5-qt fcitx5-gtk fcitx5-configtool

# Services
sudo sudo systemctl enable bluetooth.service
sudo sudo systemctl enable input-remapper.service

# Stow dotfiles
cd "$SCRIPT_DIR"/dotfiles && stow -t $HOME dunst fastfetch fcitx5 hypr input-remapper kitty micro MyScripts rofi starship waybar zsh swappy electron-flags

# COPY ASSETS
cd "$SCRIPT_DIR"/assets
# Copy fonts
sudo mkdir -p /usr/local/share/fonts/ttf
sudo cp -r fonts/* /usr/local/share/fonts/ttf
sudo fc-cache
# Copy grub background & font
sudo cp grub-theme/* /boot/grub
# Copy sddm theme
sudo cp -r sddm-theme/KDE-Story-Dark-SDDM-6 /usr/share/sddm/themes
sudo sh -c 'echo -e "[Theme]\nCurrent=KDE-Story-Dark-SDDM-6"' >> /etc/sddm.conf.d/sddm.conf
# Copy cursors and GTK theme
mkdir -p "$HOME"/.local/share/icons
mkdir -p "$HOME"/.local/share/themes
cp -r gtk-theme/* "$HOME"/.local/share/themes
cp -r cursors/* "$HOME"/.local/share/icons
echo -e 'GRUB_FONT="/boot/grub/zed-mono-nerd.pf2"\nGRUB_BACKGROUND="/boot/grub/background.jpg"' | sudo tee -a /etc/default/grub > /dev/null && sudo grub-mkconfig -o /boot/grub/grub.cfg
