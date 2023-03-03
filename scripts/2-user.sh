#!/usr/bin/env bash
# @file User
# @brief User customizations and AUR package installation.

source $HOME/ArchTitus/configs/setup.conf
cd ~
echo "INSTALLING PACKAGES FROM kde.txt"
sed -n 's/^\s*#.*//; /^[[:space:]]*$/d; p' ~/ArchTitus/pkg-files/kde.txt | while read line
do
    echo "INSTALLING: ${line}"
    sudo pacman -S --noconfirm --needed "${line}"
done

cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ~/yay
makepkg -si --noconfirm
echo "INSTALLING PACKAGES FROM aur-pkgs.txt"
sed -n 's/^\s*#.*//; /^[[:space:]]*$/d; p' ~/ArchTitus/pkg-files/aur-pkgs.txt | while read line
do
    echo "INSTALLING: ${line}"
    yay -S --noconfirm --needed "${line}"
done

export PATH=$PATH:~/.local/bin

#Theming DE if user chose FULL installation
#if [ "$INSTALL_TYPE" == "FULL" ]; then
#    cp -r ~/ArchTitus/configs/.config/* ~/.config/
#    pip install konsave
#    konsave -i ~/ArchTitus/configs/kde.knsv
#    sleep 1
#    konsave -a kde
#fi

echo -ne "~~ Starting 3-post-setup ~~"
exit