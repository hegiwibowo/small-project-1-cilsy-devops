#!/bin/bash

echo "Update Repository Ubuntu"
sudo apt update && sudo apt full-upgrade -y
echo "Done!!!"
echo "======================="

echo "Installation Webserver NGINX"
sudo apt install nginx -y
echo "Done!!!"
echo "========================"

echo "Installation PHP"
sudo apt install php-fpm php-mysql -y
echo "Done!!!"
echo "======================="

echo "Creating Directory Project Deployment"
sudo mkdir -p /var/www/welcome.local/html/
sudo mkdir -p /var/www/iwordpress.local/html/
sudo mkdir -p /var/www/isosmed.local/html/
echo "Done!!!"
echo "========================="

echo "Set Ownership Direktori Server Blocks"
sudo chown -R vagrant:vagrant /var/www/welcome.local/html/
sudo chown -R vagrant:vagrant /var/www/iwordpress.local/html/
sudo chown -R vagrant:vagrant /var/www/isosmed.local/html/
echo "Done!!!"
echo "========================="

echo "Set Permission Folder /var/www/"
sudo chmod -R 755 /var/www
echo "Done!!!"
echo "========================"

# CLONE SOURCE CODE
echo "Clone Source Code landing-page"
https://github.com/endiwinanda/landing-page.git
mv landing-page/* /var/www/welcome.local/html/
rm -rf landing-page
echo "Done!!!"
echo "========================"
 
echo "Clone WordPress"
git clone https://github.com/endiwinanda/wordpress.git
mv wordpress/* /var/www/iwordpress.local/html/
rm -rf wordpress
sudo cp /var/www/iwordpress.local/html/wp-config-sample.php /var/www/iwordpress.local/html/wp-config.php
sudo sed -i 's/database_name_here/wordpress_db/g' /var/www/iwordpress.local/html/wp-config.php
sudo sed -i 's/username_here/devopscilsy/g' /var/www/iwordpress.local/html/wp-config.php
sudo sed -i 's/password_here/1234567890/g' /var/www/iwordpress.local/html/wp-config.php
sudo sed -i 's/localhost/10.10.17.11/g' /var/www/iwordpress.local/html/wp-config.php
echo "Done!!!"
echo "========================"

echo "Clone sosial-media"
git clone https://github.com/endiwinanda/sosial-media.git
mv sosial-media/* /var/www/isosmed.local/html/
rm -rf sosial-media
sed -i 's/localhost/10.10.17.11/g' /var/www/isosmed.local/html/config.php
echo "Done!!!"
echo "========================"

echo "Configuration Nginx"
sudo cp /vagrant/landing-page /etc/nginx/sites-available/landing-page
sudo cp /vagrant/wordpress /etc/nginx/sites-available/wordpress
sudo cp /vagrant/sosial-media /etc/nginx/sites-available/sosial-media
sudo ln -s /etc/nginx/sites-available/landing-page /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/sosial-media /etc/nginx/sites-enabled/
echo "Done!!!"
echo "========================"

echo "Restart Service"
sudo nginx -t
sudo nginx -s reload
sudo systemctl restart php7.4-fpm.service
sudo systemctl restart nginx.service
echo "Done!!!"
echo "========================"