# base-php-fpm-nginx

Base image for running php-fpm/nginx applications.

# Base image

The base image, for ease of use is `ubuntu:xenial`.

# Software

__Php related:__

- php-cli
- php-opcache
- php-amqp
- php-mysql
- php-igbinary
- php-msgpack
- php-imagick
- php-curl
- php-gd
- php-intl
- php-json
- php-ldap
- php-memcache
- php-memcached
- php-readline
- php-fpm
- php-zip
- php-mcrypt (for php < 7.2)
- composer + prestissimo (global)

__Non-php related:__

- unzip
- vim
- net-tools
- telnet
- curl
- wget
- nginx
- runit
- bc
- telnet

# Technical details

__Process manager:__ - runit

- config located at: `/etc/service/` inside docker, `./_rootfs/etc/service/` outside docker
- the process manager takes care of keeping all the other services alive while the docker is running

__Services:__ 

- php-fpm
    - config located at: `/etc/php/global` inside docker, `./_rootfs/etc/php/global` outside docker
    - service file: `/etc/service/fpm/run` inside docker, `./_rootfs/etc/service/fpm/run` outside docker
    - default configuration provided under `/etc/php/global`
    - default index.php file provided at: `/var/www/html/index.php` inside docker, `./_rootfs/var/www/html/index.php` outside docker. Index contains phpinfo for checking quickly the image.
    - opcache is enabled and configured, environment variables are specified in the default pool
    - __child processes run as root to avoid file permission issues__

- nginx
    - config located at: `/etc/nginx` inside docker, `./_rootfs/etc/nginx/` outside docker
    - service file: `/etc/service/nginx/run` inside docker, `./_rootfs/etc/service/nginx/run` outside docker
    - __child processes run as root to avoid file permission issues__

# Versions

- westwing/ww-images:base-nginx-php-fpm-5.6
- westwing/ww-images:base-nginx-php-fpm-7.0
- westwing/ww-images:base-nginx-php-fpm-7.1
- westwing/ww-images:base-nginx-php-fpm-7.2

# Maintainers

- Cristian Datculescu <cristian.datculescu@westwing.de>
- srg <srg@westwing.de>
