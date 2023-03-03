#!/usr/bin/env bash
#Post-Setup: Finalizing installation configurations and cleaning up after script.

source ${HOME}/arch/configs/setup.conf

if [[ -d "/sys/firmware/efi" ]]; then
    grub-install --efi-directory=/boot ${DISK}
fi

#set kernel parameter for adding splash screen
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="[^"]*/& splash /' /etc/default/grub
echo -e "Updating grub..."
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "All set!"

systemctl enable sddm.service
echo [Theme] >> /etc/sddm.conf
echo Current=Dexy >> /etc/sddm.conf
#Set default lightdm-webkit2-greeter theme to Litarvan
sed -i 's/^webkit_theme\s*=.*/webkit_theme = litarvan/' /etc/lightdm/lightdm-webkit2-greeter.conf
#Set default lightdm greeter to lightdm-webkit2-greeter
sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-webkit2-greeter/' /etc/lightdm/lightdm.conf
sudo pacman -S --noconfirm --needed lightdm lightdm-gtk-greeter
systemctl enable lightdm.service

systemctl enable cups.service
echo "  Cups enabled"
ntpd -qg
systemctl enable ntpd.service
echo "  NTP enabled"
systemctl disable dhcpcd.service
echo "  DHCP disabled"
systemctl stop dhcpcd.service
echo "  DHCP stopped"
systemctl enable NetworkManager.service
echo "  NetworkManager enabled"
systemctl enable bluetooth
echo "  Bluetooth enabled"
systemctl enable avahi-daemon.service
echo "  Avahi enabled"

SNAPPER_CONF="$HOME/arch/configs/etc/snapper/configs/root"
mkdir -p /etc/snapper/configs/
cp -rfv "${SNAPPER_CONF}" /etc/snapper/configs/
SNAPPER_CONF_D="$HOME/arch/configs/etc/conf.d/snapper"
mkdir -p /etc/conf.d/
cp -rfv "${SNAPPER_CONF_D}" /etc/conf.d/

PLYMOUTH_THEMES_DIR="$HOME/arch/configs/usr/share/plymouth/themes"
PLYMOUTH_THEME="arch-glow" #can grab from config later if we allow selection
mkdir -p /usr/share/plymouth/themes
echo 'Installing Plymouth theme...'
cp -rf "${PLYMOUTH_THEMES_DIR}/${PLYMOUTH_THEME}" /usr/share/plymouth/themes/
echo 'Setting Plymouth as default boot splash...'
plymouth-set-default-theme ${PLYMOUTH_THEME}

#Remove no password sudo rights
sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/#%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
sed -i 's/^%wheel ALL=(ALL:ALL) NOPASSWD: ALL/#%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
#Add sudo rights
sed -i 's/^#%wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
sed -i 's/^#%wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

rm -r $HOME/arch
rm -r /home/$USERNAME/arch

#Replace in the same state
cd $pwd