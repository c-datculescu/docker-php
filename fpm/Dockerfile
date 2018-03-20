ARG PHP_MAJOR_VERSION=5.6
FROM cdatculescu/php:cli-${PHP_MAJOR_VERSION}

ARG DEBIAN_FRONTEND=noninteractive
ARG PHP_MAJOR_VERSION=5.6

ADD ./_rootfs/build.sh /build.sh
ADD ./_rootfs/calculate_fpm_workers.sh /calculate_fpm_workers.sh
RUN chmod +x /build.sh && bash /build.sh
ADD ./_rootfs/run_base.sh /run_base.sh
ADD ./_rootfs/etc/service/ /etc/service
ADD ./_rootfs/etc/consul-template/ /etc/consul-template
RUN chmod +x /etc/service/nginx/run /etc/service/fpm/run
ADD ./_rootfs/etc/nginx/ /etc/nginx/
ADD ./_rootfs/etc/php/ /etc/php
ADD ./_rootfs/var/www/ /var/www/

CMD [ "bash", "/run_base.sh" ]
