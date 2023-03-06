#!/usr/bin/env bash
# @file User
# @brief User customizations and AUR package installation.

source "$HOME/ArchTitus/configs/setup.conf"

cd "$HOME"
sed -n 's/^\s*#.*//; /^[[:space:]]*$/d; p' "$HOME/ArchTitus/pkg-files/kde.txt" | while read line
do
    sudo pacman -S --noconfirm --needed "${line}"
done

cd "$HOME"
git clone "https://aur.archlinux.org/yay.git"
cd "$HOME/yay"
makepkg -si --noconfirm
sed -n 's/^\s*#.*//; /^[[:space:]]*$/d; p' "$HOME/ArchTitus/pkg-files/aur-pkgs.txt" | while read line
do
    yay -S --noconfirm --needed "${line}"
done

export PATH="$PATH:$HOME/.local/bin"

# Theming DE if user chose FULL installation
# cp -r "$HOME/ArchTitus/configs/.config/*" "$HOME/.config/"
# pip install konsave
# konsave -i "$HOME/ArchTitus/configs/kde.knsv"
# sleep 1
# konsave -a kde

echo -e "___________________________________

Starting 3-post-setup

___________________________________"
exit