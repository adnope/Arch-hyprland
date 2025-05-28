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
pacman -Syu zsh stow git
chsh -s /usr/bin/zsh
```

Restart your PC to Arch Linux.

## 2. Installing packages

### Stow the dotfiles:

```
cd & git clone https://github.com/adnope/Arch-hyprland
cd Arch-hyprland
stow config
```

### Main programs:

```
sudo pacman -S dunst fastfetch swaybg hyprpicker hyprlock kitty micro rofi-wayland rofi-calc starship waybar nemo nemo-fileroller spotify-launcher cliphist brightnessctl playerctl grim slurp swappy ark fzf zoxide eza bat guvcview nwg-look
```

### System/dependency packages:

```
sudo pacman -S imagemagick blueman bluez ffmpegthumbnailer polkit-kde-agent kwallet kwallet-pam libheif libpulse libraw linux-headers linux-zen-headers network-manager-applet os-prober pavucontrol jq man tldr
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

### Setting up Nvidia modules

Include these modules in `/etc/mkinitcpio.conf`:
```
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```
Then regenerate initramfs:
```
sudo mkinitcpio -P
```

### KWallet auto unlock

Make sure these lines are present in `/etc/pam.d/sddm`:
```
auth            optional        pam_kwallet5.so
session         optional        pam_kwallet5.so auto_start
```

### Setting up swapfile for hibernation

Some [instructions](https://wiki.archlinux.org/title/Swap#Swap_file_creation) to create a swapfile from the ArchWiki:
```
# 15897128960 bytes equal 14 GiB or 16GB
sudo mkswap -U clear --size 15897128960 --file /swapfile
sudo swapon /swapfile
sudo echo "/swapfile none swap defaults 0 0" >> /etc/fstab
```

Add the `resume` hook to `/etc/mkinitcpio.conf`, for example:
```
HOOKS=(...filesystems resume fsck)
```

Add the resume and resume_offset parameters to the grub config:
```
# /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet resume=UUID=123456 resume_offset=123456"
```

The UUID is the UUID of the partition containing the swapfile and can be retrieved with:
```
lsblk -f
```

Get the offset parameter with this command:
```
sudo filefrag -v /swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}'
```