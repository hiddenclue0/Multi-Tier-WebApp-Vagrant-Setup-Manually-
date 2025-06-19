#!/bin/bash

# Update system and install required packages
sudo dnf update -y
sudo dnf install epel-release -y
sudo dnf install wget -y

# Add RabbitMQ repository and install RabbitMQ
sudo dnf -y install centos-release-rabbitmq-38
sudo dnf --enablerepo=centos-rabbitmq-38 -y install rabbitmq-server

# Enable and start RabbitMQ server
sudo systemctl enable --now rabbitmq-server

# Allow non-local connections by disabling loopback restriction
sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'

# Create RabbitMQ user with admin rights
sudo rabbitmqctl add_user test test
sudo rabbitmqctl set_user_tags test administrator
sudo rabbitmqctl set_permissions -p / test ".*" ".*" ".*"

# Restart RabbitMQ to apply changes
sudo systemctl restart rabbitmq-server

# Start and enable firewall
sudo systemctl start firewalld
sudo systemctl enable firewalld

# Open RabbitMQ port
sudo firewall-cmd --add-port=5672/tcp
sudo firewall-cmd --runtime-to-permanent

# Ensure RabbitMQ is running and enabled
sudo systemctl start rabbitmq-server
sudo systemctl enable rabbitmq-server
sudo systemctl status rabbitmq-server

echo "✅ rmq01 (RabbitMQ) setup complete."
