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
sed -n '/'$INSTALL_TYPE'/q;p' ~/ArchTitus/pkg-files/${DESKTOP_ENV}.txt
sudo pacman -S --noconfirm --needed ${line}
done

cd ~
git clone "https://aur.archlinux.org/$AUR_HELPER.git"
cd ~/$AUR_HELPER
makepkg -si --noconfirm
sed -n '/'$INSTALL_TYPE'/q;p' ~/ArchTitus/pkg-files/aur-pkgs.txt
    $AUR_HELPER -S --noconfirm --needed ${line}
  done
fi

export PATH=$PATH:~/.local/bin

#Theming DE
cp -r ~/ArchTitus/configs/.config/* ~/.config/
pip install konsave
konsave -i ~/ArchTitus/configs/kde.knsv
sleep 1
konsave -a kde
fi

echo -ne "
-------------------------------------------------------------------------
                    SYSTEM READY FOR 3-post-setup.sh
-------------------------------------------------------------------------
"
exit
