#!/bin/bash

set -e

# Copy fonts
sudo mkdir -p /usr/local/share/fonts/ttf
sudo cp -r fonts/* /usr/local/share/fonts/ttf
sudo fc-cache

# Copy grub background & font
sudo cp grub-theme/* /boot/grub

# Copy sddm theme
sudo cp -r sddm-theme/KDE-Story-Dark-SDDM-6 /usr/share/sddm/themes

# Copy cursors and GTK theme
mkdir -p "$HOME"/.local/share/icons
mkdir -p "$HOME"/.local/share/themes
cp -r gtk-theme/* "$HOME"/.local/share/themes
cp -r cursors/* "$HOME"/.local/share/icons