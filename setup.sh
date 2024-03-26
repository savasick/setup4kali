#!/bin/bash

sudo apt install tar curl python3 python3-scapy fail2ban ufw rkhunter lynis -y

dir_name="Tools"
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

  read -p "Do you want to download Atom ide? (y/n) " -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    wget https://github.com/atom/atom/releases/download/v1.60.0/atom-amd64.deb
    sudo apt install ./atom-amd64.deb
    echo "alias atom='/usr/bin/atom --no-sandbox'" >> ~/.zshrc
  else
    echo "Download Atom skiped"
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

  read -p "Do you want to download the Telegram-desktop? (y/n) " -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    echo "Downloading Telegram-desktop"
    sudo apt install telegram-desktop -y
  else
    echo "Download Telegram-desktop skiped"
  fi
  echo ""

  read -p "Do you want to download the Discord? (y/n) " -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    echo "Downloading Discord"
    wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
    sudo dpkg -i discord.deb
  else
    echo "Download Discord skiped"
  fi
  echo ""

read -p "Do you want to download the Element-desktop for Matrix chats? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Downloading Element-desktop"
  sudo apt install -y wget apt-transport-https
  sudo wget -O /usr/share/keyrings/element-io-archive-keyring.gpg https://packages.element.io/debian/element-io-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/element-io-archive-keyring.gpg] https://packages.element.io/debian/ default main" | sudo tee /etc/apt/sources.list.d/element-io.list
  sudo apt update -y
  sudo apt install element-desktop -y
else
  echo "Download Element-desktop skiped"
fi
echo ""

read -p "Do you want to download the Brave browser? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Downloading Brave browser"
  sudo apt install curl
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update -y
  sudo apt install brave-browser -y
  echo "brave installed"
else
  echo "Download Brave browser skiped"
fi
echo ""

cd ..
mv "$dir_name" $HOME


echo "Done. Enjoy!"
echo "Set TimeZone!"
