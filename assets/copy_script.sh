#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Copy fonts
sudo mkdir -p "/usr/local/share/fonts/ttf"
sudo cp -r "$SCRIPT_DIR"/fonts/* "/usr/local/share/fonts/ttf"
sudo fc-cache

# Copy grub background & font
sudo cp "$SCRIPT_DIR"/grub-theme/* "/boot/grub"

# Copy sddm theme
sudo cp -r "$SCRIPT_DIR"/sddm-theme/KDE-Story-Dark-SDDM-6 "/usr/share/sddm/themes"