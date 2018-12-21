#!usr/bin/bash

# Installing build essentials
sudo apt-get install -y build-essential libssl-dev

# Git and friends
sudo apt-get update
sudo apt-get install -y git xclip curl zip

#Install Apache
sudo apt update
sudo apt install apache2

## PHP ##
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php7.2 php7.2-cli php7.2-common php7.2-curl php7.2-dev libapache2-mod-php7.2 php7.2-gd php7.2-mbstring php7.2-json php7.2-mysql php7.2-readline php7.2-sqlite3

##Enable PHP7.2 for apache
a2enmod php7.2

## Copmposer ##
cd ~
EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet
RESULT=$?
rm composer-setup.php
exit $RESULT
