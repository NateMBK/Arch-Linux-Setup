#!/usr/bin/env bash
#github-action genshdoc
#
# @file User
# @brief User customizations and AUR package installation.
echo -ne "

-------------------------------------------------------------------------
                    Automated Arch Linux Installer
                        SCRIPTHOME: ArchTitus
-------------------------------------------------------------------------

Installing AUR Softwares
"
source $HOME/ArchTitus/configs/setup.conf
cd ~
sed -n ~/ArchTitus/pkg-files/kde.txt | while read line
echo "INSTALLING: ${line}"
sudo pacman -S --noconfirm --needed ${line}

cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ~/yay
makepkg -si --noconfirm
sed -n ~/ArchTitus/pkg-files/aur-pkgs.txt | while read line
echo "INSTALLING: ${line}"
yay -S --noconfirm --needed ${line}
fi

export PATH=$PATH:~/.local/bin

#Theming DE if user chose FULL installation
#cp -r ~/ArchTitus/configs/.config/* ~/.config/
# pip install konsave
#konsave -i ~/ArchTitus/configs/kde.knsv
#sleep 1
#konsave -a kde
#fi

echo -ne "
-------------------------------------------------------------------------
                    SYSTEM READY FOR 3-post-setup.sh
-------------------------------------------------------------------------
"
exit
