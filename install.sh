#!/bin/bash

sudo apt install tar curl python3 python3-scapy fail2ban ufw rkhunter lynis -y

dir_name="~/Tools"
if [ ! -d "$dir_name" ]; then
  mkdir -p "$dir_name"
  if [ $? -ne 0 ]; then
    echo "Failed to create directory $dir_name"
    exit 1
  fi
fi

cd "$dir_name"

echo "Do you want to download the password manager?"
read -p "KeePassXC (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Downloading KeePassXC"
  mkdir keepassxc
  cd keepassxc
  wget https://github.com/keepassxreboot/keepassxc/releases/download/2.7.6/KeePassXC-2.7.6-x86_64.AppImage
  wget https://github.com/keepassxreboot/keepassxc/releases/download/2.7.6/KeePassXC-2.7.6-x86_64.AppImage.sig
  wget https://github.com/keepassxreboot/keepassxc/releases/download/2.7.6/KeePassXC-2.7.6-x86_64.AppImage.DIGEST
  gpg --keyserver keys.openpgp.org --recv-keys BF5A669F2272CF4324C1FDA8CFB4C2166397D0D2
  gpg --verify KeePassXC-*.sig
  shasum -a 256 -c KeePassXC-*.DIGEST
  chmod 744 KeePassXC-2.7.6-x86_64.AppImage
  cd ..
else
  echo "Download KeePassXC skiped"
fi
echo ""


read -p "Do you want to download the VirtualBox? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Downloading VirtualBox"
  sudo apt install virtualbox -y
else
  echo "Download VirtualBox skiped"
fi
echo ""


read -p "Do you want to download the TOR / TOR tools? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Downloading TOR / TOR tools"
  sudo apt install tor torsocks obfs4proxy torbrowser-launcher -y
else
  echo "Download TOR / TOR tools skiped"
fi
echo ""


read -p "Do you want to download the network-manager and change network.conf? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Downloading network-manager and change NetworkManager.conf"
  sudo apt install network-manager -y
  sudo cp /etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/NetworkManager.conf.bak
  sudo rm -rf /etc/NetworkManager/NetworkManager.conf
  sudo cp ./NetworkManager.conf /etc/NetworkManager/NetworkManager.conf
  sudo systemctl restart systemd-networkd
else
  echo "NetworkManager skiped"
fi
  echo ""


read -p "Do you want to download whoami-project? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  git clone https://github.com/owerdogan/whoami-project.git
  cd whoami-project
  sudo make install
  cd ..
else
  echo "Download whoami-project skiped"
fi
  echo ""

read -p "Do you want to download kali-anonsurf? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  git clone https://github.com/Und3rf10w/kali-anonsurf.git
  cd kali-anonsurf
  sudo bash installer.sh
  cd ..
else
  echo "Download kali-anonsurf skiped"
fi
  echo ""



echo "Done. Enjoy!"
echo "Set TimeZone!"