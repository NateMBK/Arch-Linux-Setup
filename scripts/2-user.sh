#!/usr/bin/env bash
#User customizations and AUR package installation.

source $HOME/arch/configs/setup.conf
cd ~
echo "INSTALLING PACKAGES FROM kde.txt"
sed -n 's/^\s*#.*//; /^[[:space:]]*$/d; p' ~/arch/pkg-files/kde.txt | while read line
do
    echo "INSTALLING: ${line}"
    sudo pacman -S --noconfirm --needed "${line}"
done

cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ~/yay
makepkg -si --noconfirm
echo "INSTALLING PACKAGES FROM aur-pkgs.txt"
sed -n 's/^\s*#.*//; /^[[:space:]]*$/d; p' ~/arch/pkg-files/aur-pkgs.txt | while read line
do
    echo "INSTALLING: ${line}"
    yay -S --noconfirm --needed "${line}"
done

export PATH=$PATH:~/.local/bin

#Theming Desktop
cp -r ~/arch/configs/.config/* ~/.config/
pip install konsave
konsave -i ~/arch/configs/kde.knsv
sleep 1
konsave -a kde

exit