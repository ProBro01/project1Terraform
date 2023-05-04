#!/bin/bash

sudo yum update
sudo yum install httpd -y
sudo mv /home/ec2-user/index.html /var/www/html/index.html
sudo systemctl start httpd
