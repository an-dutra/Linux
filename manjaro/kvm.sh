#!/bin/zsh 

# Install KVM
sudo pacman -Syu qemu libvirt virt-manager qemu-arch-extra

# Add current user to groups
# Debian Commands
#sudo addgroup "$(whoami)" libvirt
#sudo addgroup "$(whoami)" kvm

#Arch Commands
sudo gpasswd -a "$(whoami)"  libvirt
sudo gpasswd -a "$(whoami)"  kvm

echo "All done, you need to reboot the system!"
read REPLY\?"Reboot System now?(y/n)"

if [[ $REPLY == "Y" || $REPLY == "y" ]]
then
        sudo reboot
fi
