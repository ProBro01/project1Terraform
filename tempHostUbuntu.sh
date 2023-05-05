#!/bin/bash

echo "Updating APT"
sudo ls
sudo apt update -y
sudo apt -f install apache2 -y
sudo mv /home/ubuntu/index.html /var/www/html/index.html
sudo systemctl start apache2