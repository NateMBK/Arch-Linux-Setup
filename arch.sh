#!/bin/bash
#Entrance script that launches children scripts for each phase of installation.

#Finds the name of the folder the scripts are in
set -a
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPTS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/scripts
CONFIGS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/configs
set +a

( bash $SCRIPT_DIR/scripts/startup.sh )
  source $CONFIGS_DIR/setup.conf
( bash $SCRIPT_DIR/scripts/0-preinstall.sh )
( arch-chroot /mnt $HOME/arch/scripts/1-setup.sh )
( arch-chroot /mnt /usr/bin/runuser -u $USERNAME -- /home/$USERNAME/arch/scripts/2-user.sh )
( arch-chroot /mnt $HOME/arch/scripts/3-post-setup.sh )