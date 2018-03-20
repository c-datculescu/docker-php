#!/bin/bash

set +ex

apt-get update && \
    apt-get install --no-install-recommends -yqq \
        software-properties-common \
        language-pack-en-base \
        apt-utils && \
    LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install -yqq --no-install-recommends \
        php${PHP_MAJOR_VERSION}-cli \
        php${PHP_MAJOR_VERSION}-opcache \
        php-amqp \
        php${PHP_MAJOR_VERSION}-mysql \
        php-igbinary \
        php-msgpack \
        php-imagick \
        php${PHP_MAJOR_VERSION}-curl \
        php${PHP_MAJOR_VERSION}-gd \
        php${PHP_MAJOR_VERSION}-intl \
        php${PHP_MAJOR_VERSION}-json \
        php${PHP_MAJOR_VERSION}-ldap \
        php-memcache \
        php-memcached \
        php${PHP_MAJOR_VERSION}-readline \
        php${PHP_MAJOR_VERSION}-zip \
        php${PHP_MAJOR_VERSION}-simplexml \
        php${PHP_MAJOR_VERSION}-mbstring \
        php${PHP_MAJOR_VERSION}-dom \
        php${PHP_MAJOR_VERSION}-xml \
        unzip \
        ca-certificates \
        apt-transport-https \
        vim \
        net-tools \
        curl \
        wget \
        bc \
        telnet

wget https://releases.hashicorp.com/consul-template/0.19.4/consul-template_0.19.4_linux_amd64.tgz -O /tmp/consul-template.tar.gz > /dev/null
mkdir /tmp/consul-template
cd /tmp && tar -xvf consul-template.tar.gz -C /tmp/consul-template > /dev/null
mv /tmp/consul-template/consul-template /usr/local/bin/consul-template && rm -rf /tmp/consul-template.tar.gz /tmp/consul-template

# install composer globally
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer
php -r "unlink('composer-setup.php');"

# require composer prestissimo for parrallel downloads of packages
composer global require hirak/prestissimo

# mcrypt is removed in php 7.2 and up. dont install
if (( $(echo "$PHP_MAJOR_VERSION < 7.2" | bc -l) )); then
    apt-get install -yqq php${PHP_MAJOR_VERSION}-mcrypt
fi

# symlink the php-fpm exec to a global one
ln -s /usr/sbin/php${PHP_MAJOR_VERSION} /usr/sbin/php

# move the configuration into global and symlink global over the needed php version
mv /etc/php/${PHP_MAJOR_VERSION} /etc/php/global
ln -s /etc/php/global /etc/php/${PHP_MAJOR_VERSION}
