#!/bin/bash

echo 'Updating'
apt-get update 
echo 'Upgrade'
apt-get upgrade
echo 'Ngix Install and Php Install'
apt-get install nginx php5-fpm php5-cli php5-mcrypt git
sudo apt-get install php5-gd
php -i | grep -i gd
