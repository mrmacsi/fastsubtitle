#!/bin/sh
#!/bin/bash

echo '***********************************'
echo '**************Updating*************'
echo '***********************************'
apt-get update  # To get the latest package lists
echo '***********************************'
echo '**************Upgrade**************'
echo '***********************************'
apt-get -y upgrade [packagename]
echo '***********************************'
echo '***********Ngix İnstall************'
echo '***********************************'
apt-get install nginx php5-fpm php5-cli php5-mcrypt git
echo '***********************************'
echo '***********Php İnstall************'
echo '***********************************'
apt-get install php5-gd
echo '***********************************'
echo '*************Show Grep*************'
echo '***********************************'
php -i | grep -i gd
cd ..
mkdir /var/www
mkdir /var/www/laravel
nano /etc/nginx/sites-available/default
nano /etc/php5/fpm/php.ini
echo '***********************************'
echo '************Restarting*************'
echo '***********************************'
service php5-fpm restart
service nginx restart
echo '***********************************'
echo '*************Composer**************'
echo '***********************************'
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
dd if=/dev/zero of=/swapfile bs=1024 count=512k
mkswap /swapfile
swapon /swapfile
echo '***********************************'
echo '***********Laravel 5.2*************'
echo '***********************************'
composer create-project laravel/laravel /var/www/laravel/ 5.2
chgrp -R www-data /var/www/laravel
chmod -R 775 /var/www/laravel/storage
apt-get -y install mysql-server
apt-get -y install php5-mysql
sudo chmod -R gu+w www
sudo chmod -R guo+w www
mysql -u root -p
123456
CREATE DATABASE fastsubtitle;
exit
#etc.
