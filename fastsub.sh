#!/bin/bash
echo '***********************************'
echo '**************Updating*************'
echo '***********************************'
sudo apt-get update
sudo apt-get -y install nginx php5-fpm php5-cli php5-mcrypt git php5-gd
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
git clone https://gitlab.com/salvadorx/demotest.git /var/www/laravel
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
sudo chmod -R gu+w /var/www/
sudo chmod -R guo+w /var/www/
clear
echo '***********************************'
echo '*************Database**************'
echo '***********************************'
mysql -u root -p
clear
echo '***********************************'
echo '**********Composer Update**********'
echo '***********************************'
cd /var/www/laravel
composer update
php artisan cache:clear
php artisan migrate:refresh --seed
