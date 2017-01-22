sudo add-apt-repository ppa:ondrej/php
sudo apt-get install -y language-pack-en-base
sudo LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php
echo "mysql-server-5.5 mysql-server/root_password password 123984" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password 123984" | debconf-set-selections
sudo apt-get -y update && apt-get -y --purge autoremove && apt-get -y install git nginx php7.0-fpm  php7.0-mysql php7.0-cli php7.0-curl php7.0-gd php7.0-json php7.0-mcrypt php7.0-xml php7.0-mbstring zip unzip php7.0-zip mysql-server-5.5
service php7.0-fpm restart
service nginx restart
sudo chmod -R gu+w /var/www/
sudo chmod -R guo+w /var/www/
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
git clone https://gitlab.com/salvadorx/fastsubtitle.git /var/www/laravel
sudo chown -R :www-data /var/www/laravel
sudo chmod -R 777 /var/www/laravel/storage
sudo chmod -R 777 /var/www/laravel/bootstrap
curl -O https://raw.githubusercontent.com/mrmacsi/fastsubtitle/master/.env
sudo mv .env /var/www/laravel
cd /var/www/laravel
composer install
mysql --host="localhost" --user=root --password=123984  -e "create database fastsubtitle;"
curl -O https://raw.githubusercontent.com/mrmacsi/fastsubtitle/master/default
mv default /etc/nginx/sites-available/
curl -O https://raw.githubusercontent.com/mrmacsi/fastsubtitle/master/php7/php.ini
mv php.ini /etc/php/7.0/
sudo chown $(whoami):www-data /var/www/laravel/. -R
sudo chown www-data: /var/www/laravel/storage -R
chmod -R 777 /var/www/laravel/public/backend/peopleImages/
chmod -R 777 /var/www/laravel/public/backend/videoImages/
/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
/sbin/mkswap /var/swap.1
/sbin/swapon /var/swap.1
cd /var/www/laravel
composer update
php artisan cache:clear
php artisan optimize
php artisan migrate
service php7.0-fpm restart
service nginx restart
echo '***********************************'
echo '**********Setup Complated**********'
echo '***********************************'
