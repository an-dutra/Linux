#!/bin/zsh

read REPLY\?"Should I install kvm?(y/n)"

if [[ $REPLY == "Y" || $REPLY == "y" ]]
then
        zsh ./kvm.sh
fi

echo "Downloading Whonix Image..."
# Downloading Images
mkdir ~/Downloads/Whonix
wget https://download.whonix.org/libvirt/16.0.3.7/Whonix-XFCE-16.0.3.7.Intel_AMD64.qcow2.libvirt.xz > ~/Downloads/Whonix/Whonix-XFCE-16.0.3.7.Intel_AMD64.qcow2.libvirt.xz


# Starting KVM network
sudo virsh -c qemu:///system net-autostart default
sudo virsh -c qemu:///system net-start default

# Extracting Whonix Files
cd ~/Downloads/Whonix
tar -xvf Whonix*.libvirt.xz

# Agreeing with license
touch WHONIX_BINARY_LICENSE_AGREEMENT_accepted

# Importing Templates
sudo virsh -c qemu:///system net-define Whonix_external*.xml
sudo virsh -c qemu:///system net-define Whonix_internal*.xml

# Activating Virtual Networks
sudo virsh -c qemu:///system net-autostart Whonix-External
sudo virsh -c qemu:///system net-start Whonix-External
sudo virsh -c qemu:///system net-autostart Whonix-Internal
sudo virsh -c qemu:///system net-start Whonix-Internal

# Importing Whonix Gateway and Workstation
sudo virsh -c qemu:///system define Whonix-Gateway*.xml
sudo mv Whonix-Gateway*.qcow2 /var/lib/libvirt/images/Whonix-Gateway.qcow2
read Workstation\?"Import Workstation?(y/n)"
if [[ $Workstation == "Y" || $Workstation == "y" ]]
then
    sudo virsh -c qemu:///system define Whonix-Workstation*.xml
    sudo mv Whonix-Workstation*.qcow2 /var/lib/libvirt/images/Whonix-Workstation.qcow2
fi

# Cleanup data
cd ~
rm -fr ~/Downloads/Whonix