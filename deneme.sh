#!/bin/bash
echo '***********************************'
echo '**************Updating*************'
echo '***********************************'
sudo apt-get update
clear 
echo '***********************************'
echo '**************Upgrade**************'
echo '***********************************'
apt-get -y upgrade
clear 
echo '***********************************'
echo '***********Ngix İnstall************'
echo '***********************************'
sudo -y apt-get install nginx php5-fpm php5-cli php5-mcrypt git
clear 
echo '***********************************'
echo '***********Php İnstall************'
echo '***********************************'
apt-get -y install php5-gd
sudo nano /etc/php5/fpm/php.ini
sudo php5enmod mcrypt
sudo service php5-fpm restart
clear 
echo '***********************************'
echo '*************Show Grep*************'
echo '***********************************'
php -i | grep -i gd
sudo mkdir -p /var/www/laravel
sudo nano /etc/nginx/sites-available/default
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
cd ~
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
clear 
echo '***********************************'
echo '**************GitLab***************'
echo '***********************************'
git clone https://gitlab.com/salvadorx/demotest.git /var/www/laravel
mv /var/www/laravel/demotest/* /var/www/laravel
rm -rf /var/www/laravel/demotest
sudo chown -R :www-data /var/www/laravel
sudo chmod -R 775 /var/www/laravel/storage
cd /var/www/laravel
composer install
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
clear
echo '***********************************'
echo '**********Composer Update**********'
echo '***********************************'
composer update
php artisan cache:clear
