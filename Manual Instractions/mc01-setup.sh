#!/bin/bash

# Update system and install memcached
sudo dnf update -y
sudo dnf install epel-release -y
sudo dnf install memcached -y

# Start and enable memcached
sudo systemctl start memcached
sudo systemctl enable memcached
sudo systemctl status memcached

# Configure memcached to listen on all interfaces
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/sysconfig/memcached
sudo systemctl restart memcached

# Start memcached with UDP and TCP on specific ports
sudo memcached -p 11211 -U 11111 -u memcached -d

# Logout db01
exit
