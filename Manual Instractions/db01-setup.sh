#!/bin/bash

# Update packages and install MariaDB
sudo dnf update -y
sudo dnf install epel-release -y
sudo dnf install git mariadb-server -y

# Start and enable MariaDB
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Secure MariaDB Installation
echo "Securing MariaDB..."
sudo mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY 'admin123';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
FLUSH PRIVILEGES;
EOF

# Create database and user
sudo mysql -u root -padmin123 <<EOF
CREATE DATABASE accounts;
GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'localhost' IDENTIFIED BY 'admin123';
GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'%' IDENTIFIED BY 'admin123';
FLUSH PRIVILEGES;
EOF

# Clone project and import DB
cd /tmp/
git clone -b local https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project
mysql -u root -padmin123 accounts < src/main/resources/db_backup.sql

# Firewall settings
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --zone=public --add-port=3306/tcp --permanent
sudo firewall-cmd --reload

# Restart MariaDB to apply everything
sudo systemctl restart mariadb

echo "✅ db01 setup complete."
