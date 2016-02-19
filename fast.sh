#!/bin/bash

echo '***********************************'
echo '**************Updating*************'
echo '***********************************'
apt-get update  # To get the latest package lists
clear 
echo '***********************************'
echo '**************Upgrade**************'
echo '***********************************'
apt-get -y upgrade
clear 
echo '***********************************'
echo '***********Ngix İnstall************'
echo '***********************************'
apt-get -y install nginx php5-fpm php5-cli php5-mcrypt git
clear 
echo '***********************************'
echo '***********Php İnstall************'
echo '***********************************'
apt-get -y install php5-gd
clear 
echo '***********************************'
echo '*************Show Grep*************'
echo '***********************************'
php -i | grep -i gd
cd ..
mkdir /var/www
mkdir /var/www/laravel
nano /etc/nginx/sites-available/default
nano /etc/php5/fpm/php.ini
clear 
echo '***********************************'
echo '************Restarting*************'
echo '***********************************'
service php5-fpm restart
service nginx restart
clear 
echo '***********************************'
echo '*************Composer**************'
echo '***********************************'
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
dd if=/dev/zero of=/swapfile bs=1024 count=512k
mkswap /swapfile
swapon /swapfile
clear 
echo '***********************************'
echo '***********Laravel 5.2*************'
echo '***********************************'
composer create-project laravel/laravel /var/www/laravel/ 5.2
chgrp -R www-data /var/www/laravel
chmod -R 775 /var/www/laravel/storage
clear 
echo '***********************************'
echo '**************Mysql****************'
echo '***********************************'
apt-get -y install mysql-server
apt-get -y install php5-mysql
sudo chmod -R gu+w www
sudo chmod -R guo+w www
clear
echo '***********************************'
echo '*************Database**************'
echo '***********************************'
mysql -u root -p
