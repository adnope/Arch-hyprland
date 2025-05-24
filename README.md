# My hyprland config for a fresh Arch installation

## 1. Initial setup

Start a fresh Arch installation with the `archinstall` script. The following options are recommended:
- bootloader: grub
- grub partition: /boot/grub
- login manager: sddm
- profile: desktop - hyprland, nvidia (proprietary)
- sound: pipewire
- network: NetworkManager

Post-install commands:
```
pacman -S zsh stow git
chsh -s /usr/bin/zsh
```

Restart your PC to Arch Linux.

## 2. Installing packages

### Copy dotfiles as symlinks:

```
cd & git clone https://github.com/adnope/Arch-hyprland
cd Arch-hyprland
stow config
```

### Main programs:

```
sudo pacman -S dunst fastfetch hyprpaper hyprpicker kitty micro rofi-wayland starship waybar fzf nemo nemo-fileroller spotify-launcher cliphist brightnessctl playerctl git grim slurp swappy ark jq swaybg zoxide
```

### System/dependency packages:

```
sudo pacman -S imagemagick blueman bluez ffmpegthumbnailer polkit-kde-agent kwallet kwallet-pam libheif libpulse libraw linux-headers linux-zen-headers network-manager-applet os-prober pavucontrol
```

### AUR packages:

```
yay -S input-remapper-git visual-studio-code-bin zen-browser-bin
```

### Vietnamese input method:

```
sudo pacman -S fcitx5 fcitx5-bamboo fcitx5-configtool fcitx5-qt fcitx5-gtk fcitx5-configtool
```

## 2. Themes & fonts

### SDDM, grub, cursors & fonts

```
./assets/copy_script.sh
sudo sh -c 'echo -e "[Theme]\nCurrent=KDE-Story-Dark-SDDM-6"' >> /etc/sddm.conf.d/sddm.conf
echo -e 'GRUB_FONT="/boot/grub/zed-mono-nerd.pf2"\nGRUB_BACKGROUND="/boot/grub/background.jpg"' | sudo tee -a /etc/default/grub > /dev/null && sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### Windows fonts

```
sudo mount -m /dev/<partition> /mnt/Windows
sudo mkdir -p /usr/local/share/fonts/WindowsFonts
sudo cp /mnt/Windows/Windows/Fonts/*.ttf /usr/local/share/fonts/WindowsFonts
sudo chmod 644 /usr/local/share/fonts/WindowsFonts/*
fc-cache --force
```

## 3. Some addition steps

### KWallet auto unlock

Make sure these lines are present in `/etc/pam.d/sddm`:
```
auth            optional        pam_kwallet5.so
session         optional        pam_kwallet5.so auto_start
```