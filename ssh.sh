#!/bin/bash

echo "Create new SSH key?"
read -p "Do you want to proceed (y/n)? " answer

if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    echo "Enter your email address:"
    read EMAIL

    ssh-keygen -t ed25519 -C "$EMAIL"
    ssh-add ~/.ssh/id_ed25519
    cat ~/.ssh/id_ed25519.pub
else
    echo "Aborting..."
fi