#!/bin/bash

set +ex

apt-get update && \
    apt-get install -yqq --no-install-recommends \
        php${PHP_MAJOR_VERSION}-fpm \
        wget \
        nginx \
        runit

# symlink the php-fpm exec to a global one
ln -s /usr/sbin/php-fpm${PHP_MAJOR_VERSION} /usr/sbin/php-fpm
