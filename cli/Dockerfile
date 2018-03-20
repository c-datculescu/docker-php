FROM ubuntu:xenial

ARG DEBIAN_FRONTEND=noninteractive
ARG PHP_MAJOR_VERSION=5.6

ADD ./_rootfs/build.sh /build.sh
RUN chmod +x /build.sh && bash /build.sh
ADD ./_rootfs/etc/ /etc/
