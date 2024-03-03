#!/bin/bash

sudo apt install torbrowser-launcher tar tor curl python3 python3-scapy virtualbox network-manager fail2ban ufw rkhunter lynis -y

# Change Network Manager conf  may be its allready old
sudo cp /etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/NetworkManager.conf.bak
# Replace all instances of [main] with the desired string.
sudo rm -rf /etc/NetworkManager/NetworkManager.conf
sudo cp ./NetworkManager.conf /etc/NetworkManager/NetworkManager.conf
# Restart the NetworkManager service to apply the changes.
#sudo service network-manager restart
sudo systemctl restart systemd-networkd

# Make dir with tools
mkdir help_tools
cd help_tools

# Add whoami-project
git clone https://github.com/owerdogan/whoami-project.git
cd whoami-project
sudo make install
cd ..

# Add anonsurf
#sudo apt install valac nim
#sudo apt-get install nim
#git clone https://github.com/ParrotSec/anonsurf.git

# Add kali-anonsurf
git clone https://github.com/Und3rf10w/kali-anonsurf.git
cd kali-anonsurf
sudo bash installer.sh
cd ..

#mkdir ISO_OVA
#cd ISO_OVA
#wget https://deb.parrot.sh/parrot/iso/6.0/Parrot-security-6.0_amd64.ova
#cd ..

# install KeepassXC
mkdir passwords
cd passwords
wget https://github.com/keepassxreboot/keepassxc/releases/download/2.7.6/KeePassXC-2.7.6-x86_64.AppImage
cd ../..

cp -r help_tools ~/

# Disable root login over SSH.
sudo sed -i 's/^PermitRootLogin without-password/PermitRootLogin no/g' /etc/ssh/sshd_config

# Configure Fail2ban. it is banning IP addresses that are attempting to brute-force logins or otherwise attack the system
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo sed -i 's/^bantime  = .*/bantime  = 3600/' /etc/fail2ban/jail.local
sudo sed -i 's/^findtime = .*/findtime = 600/' /etc/fail2ban/jail.local
sudo sed -i 's/^maxretry = .*/maxretry = 3/' /etc/fail2ban/jail.local

# Enable SSH protection in Fail2ban.
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Scan the system for vulnerabilities.
#sudo rkhunter --update
#sudo rkhunter --propupd
#sudo rkhunter --check

# Install Lynis security scanner.
#sudo lynis install

# Run Lynis security scan.
#sudo lynis audit system

cd ~/
sudo chown -R $USER:$USER help_tools

echo "Done. Enjoy!"
echo "Set ur TimeZone!"