#!/bin/bash

echo "Update Repository Ubuntu Server"
sudo apt update && sudo apt full-upgrade -y
echo "======================="

echo "Installation Database Server"
sudo apt install mysql-server -y
echo "Done!!!"
echo "======================="

echo "Configuration MySQL"
sudo cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.bak
sudo sed -i "s/.*bind-address.*/bind-address = 10.10.17.11/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo service mysql stop
sudo service mysql start
echo "Done!!!"
echo "======================="

echo "Creating Database and User for Wordpress"
sudo mysql << EOF
CREATE DATABASE IF NOT EXISTS dbsosmed;
CREATE DATABASE IF NOT EXISTS wordpress_db;
CREATE USER IF NOT EXISTS 'devopscilsy'@'%' IDENTIFIED BY '1234567890';
GRANT ALL PRIVILEGES ON *.* TO 'devopscilsy'@'%';
FLUSH PRIVILEGES;
EOF
echo "Done!!!"
echo "======================="

echo "Import Database For Social-Media"
git clone https://github.com/endiwinanda/sosial-media.git
sudo mysql -u devopscilsy -p1234567890 dbsosmed < sosial-media/dump.sql
rm -rf sosial-media/
echo "Done!!!"
echo "========================"