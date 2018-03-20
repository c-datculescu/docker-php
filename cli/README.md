# base-php-cli

Base image for running long running processes like consumers.

# Base image

The base image is `ubuntu:xenial` for ease of use.

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
- php-zip
- php-mcrypt (for php < 7.2)
- composer + prestissimo (global)

__Non-php related:__
- unzip
- ca-certificates
- apt-transport-https
- vim
- net-tools
- curl
- wget
- bc
- telnet

# Providing your own configuration

Since we are using ondrej's ppa, the configuration needs to change a little bit from the normal php deployments.

Under normal circumstances, the configuration can be located under `/etc/php/cli/...`, but in the case of multiple php versions, this will be located under `/etc/php/5.6/cli...`. In order to avoid this, on build time we move all the files from there in `/etc/php/global`, and we symlink this into the proper place. 

__Therefore all the custom configurations for extensions or php.ini need to go into `/etc/php/global`.__

# Running the php binary

The php binary has the same issues as the php configuration files (aka. the binary is called `php5.6` for example). In order to avoid this issue, the binary is symlinked to `/usr/bin/php`.

So all the scripts can be easily ran using the syntax: `php script.php`

# Automatic builds

This image is automatically built and pushed to dockerhub whenever a push/merge happens on the master branch. No other branches are getting built to avoid issues with overriding images and to maintain a certain level of control.

Maintainers:

- cristian.datculescu@westwing.de
- srg@westwing.de

For any requirements please shoot an email to any of these accounts. Also please provide a pull request in case you have already the changes needed, as well as a good explanation of why this is needed (since this is a base image).

# Versions

- westwing/ww-images:base-php-cli-5.6
- westwing/ww-images:base-php-cli-7.0
- westwing/ww-images:base-php-cli-7.1
- westwing/ww-images:base-php-cli-7.2
