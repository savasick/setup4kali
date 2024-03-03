#!/bin/bash

# Make new user and add his to sudoers
read -p "Enter the new username: " username
sudo useradd -m "$username"
sudo usermod -aG sudo $username
sudo chsh -s /bin/bash $username
sudo chsh -s /bin/zsh $username
echo "created user: ${username}"
echo "change password for ${username}"
echo "by using:"
echo "sudo passwd ${username}"
echo "also change password for root and kali user (u can make it same)"
echo "sudo passwd root"
echo "sudo passwd kali"

# change autologin-user=username at /etc/lightdm/lightdm.conf 
sudo sed -i "s/autologin-user=kali/autologin-user=${username}/g" /etc/lightdm/lightdm.conf
