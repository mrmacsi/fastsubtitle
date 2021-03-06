#!/bin/bash
echo '***********************************'
echo '**************Updating*************'
echo '***********************************'
sudo apt-get update
sudo apt-get -y install nginx php5-fpm php5-cli php5-mcrypt git php5-gd php5-curl
clear 
echo '***********************************'
echo '***********Php İnstall************'
echo '***********************************'
curl -O https://raw.githubusercontent.com/mrmacsi/fastsubtitle/master/php.ini
mv php.ini /etc/php5/fpm/
sudo php5enmod mcrypt
sudo service php5-fpm restart
clear 
echo '***********************************'
echo '*************Show Grep*************'
echo '***********************************'
php -i | grep -i gd
sudo mkdir -p /var/www/laravel
curl -O https://raw.githubusercontent.com/mrmacsi/fastsubtitle/master/default
mv default /etc/nginx/sites-available/
clear 
echo '***********************************'
echo '************Restarting*************'
echo '***********************************'
sudo service nginx restart
clear 
echo '***********************************'
echo '*************Composer**************'
echo '***********************************'
cd ~
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
clear 
echo '***********************************'
echo '**************GitLab***************'
echo '***********************************'
git clone https://gitlab.com/salvadorx/fastsubtitle.git /var/www/laravel
sudo chown -R :www-data /var/www/laravel
sudo chmod -R 777 /var/www/laravel/storage
sudo chmod -R 777 /var/www/laravel/bootstrap
cd /var/www/laravel
curl -O https://raw.githubusercontent.com/mrmacsi/fastsubtitle/master/.env
composer install
clear 
echo '***********************************'
echo '**************Mysql****************'
echo '***********************************'
echo "mysql-server-5.5 mysql-server/root_password password 123984" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password 123984" | debconf-set-selections
apt-get -y install mysql-server-5.5
apt-get -y install php5-mysql
clear
echo '***********************************'
echo '*************Database**************'
echo '***********************************'
mysql --host="localhost" --user=root --password=123984  -e "create database fastsubtitle;"
sudo chmod -R gu+w /var/www/
sudo chmod -R guo+w /var/www/
clear
echo '***********************************'
echo '********Phpmyadmin Install*********'
echo '***********************************'
sudo apt-get -y install phpmyadmin
curl -O https://raw.githubusercontent.com/mrmacsi/fastsubtitle/master/nginx.conf
mv nginx.conf /etc/nginx/
clear
echo '***********************************'
echo '**********Composer Update**********'
echo '***********************************'
sudo chown $(whoami):www-data /var/www/laravel/. -R
sudo chown www-data: /var/www/laravel/storage -R
chmod -R 777 /var/www/laravel/public/backend/peopleImages/
chmod -R 777 /var/www/laravel/public/backend/videoImages/
/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
/sbin/mkswap /var/swap.1
/sbin/swapon /var/swap.1
composer update
php artisan cache:clear
php artisan optimize
php artisan migrate:refresh --seed
service php5-fpm restart
service nginx restart
clear
echo '***********************************'
echo '**********Setup Complated**********'
echo '***********************************'
