<img src="./assets/kali.png" alt="">

# Setup 4 Kali Linux Live USB Drive with Encrypted Persistence

<a href="https://www.kali.org/docs/usb/">How to get kali usb with encrypted persistence</a>

### setup

before update change sittings -> Power Manager -> Display -> Switch off after -> Never

update system
```bash
sudo apt update && sudo apt full-upgrade -y
```

start script then change passwords
```bash
bash user.sh
```
###### check code before run :)

reboot with new user
```bash
reboot
```

to install setup
```bash
bash install.sh
```
###### check code before run :)

then upgrade system again
```bash
sudo apt update -y && sudo apt full-upgrade -y
sudo apt clean
sudo apt autoremove -y
```

add tools to new user
```bash
sudo chown -R $USER:$USER help_tools
```

delete kali user
```bash
sudo pkill -9 -u kali && sudo userdel kali
```