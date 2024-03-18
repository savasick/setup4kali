echo "Do you want to create a new gpg key?"
read -p "Press y/n: " answer

if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    gpg --full-generate-key
    gpg --list-keys
    echo "Your new gpg key has been generated and listed."
else
    echo "Aborting..."
fi