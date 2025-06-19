#!/bin/bash

# Update packages and install MariaDB
sudo dnf update -y
sudo dnf install epel-release -y
sudo dnf install git mariadb-server -y

# Start and enable and status check MariaDB
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo systemctl status  mariadb

# Secure MariaDB Installation
sudo mysql_secure_installation
# Switch to unix_socket authentication [Y/n] Y
# Change the root password? [Y/n] Y
# New password: admin123
# Re-enter new password: admin123
# Remove anonymous users? [Y/n] Y
# Disallow root login remotely? [Y/n] Y
# Remove test database and access to it? [Y/n] Y
# Reload privilege tables now? [Y/n] Y

# Create database and user
sudo mysql -u root -padmin123 
MariaDB [(none)]> CREATE DATABASE accounts;
MariaDB [(none)]> GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'localhost' IDENTIFIED BY 'admin123';
MariaDB [(none)]> GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'%' IDENTIFIED BY 'admin123';
MariaDB [(none)]> FLUSH PRIVILEGES;
MariaDB [(none)]> exit;

# Clone project and import DB
cd /tmp/
git clone https://github.com/hiddenclue0/spring-multi-tier-enterprise-app.git
cd spring-multi-tier-enterprise-app
mysql -u root -padmin123 accounts < src/main/resources/db_backup.sql

# Restart MariaDB and status check
sudo systemctl restart mariadb
sudo systemctl status  mariadb

#Show databases
mysql -u root -padmin123 -e accounts
MariaDB [accounts]> show tables;
MariaDB [accounts]> exit;

# Logout db01
exit
