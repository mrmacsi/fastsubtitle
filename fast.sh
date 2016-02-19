#!/bin/sh
apt-get update  # To get the latest package lists
apt-get upgrade <package name> -y
y
apt-get install nginx php5-fpm php5-cli php5-mcrypt git
sudo apt-get install php5-gd
php -i | grep -i gd
#etc.
