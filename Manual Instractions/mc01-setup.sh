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

# Start and enable firewall
sudo systemctl start firewalld
sudo systemctl enable firewalld

# Open required TCP and UDP ports for memcached
sudo firewall-cmd --add-port=11211/tcp
sudo firewall-cmd --runtime-to-permanent
sudo firewall-cmd --add-port=11111/udp
sudo firewall-cmd --runtime-to-permanent

# Start memcached with UDP and TCP on specific ports
sudo memcached -p 11211 -U 11111 -u memcached -d

echo "✅ mc01 setup complete."
