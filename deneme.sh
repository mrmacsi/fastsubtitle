#!/bin/bash
sudo -y apt-get update
sudo -y apt-get install nginx php5-fpm php5-cli php5-mcrypt git
sudo nano /etc/php5/fpm/php.ini
sudo php5enmod mcrypt
sudo service php5-fpm restart
sudo mkdir -p /var/www/laravel
sudo nano /etc/nginx/sites-available/default
sudo service nginx restart
cd ~
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
