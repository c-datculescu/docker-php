#!/bin/bash

set -ex

# small bash for building all the versions of the cli image
docker build --build-arg PHP_MAJOR_VERSION=5.6 -t cdatculescu/php:cli-5.6 .
docker build --build-arg PHP_MAJOR_VERSION=7.0 -t cdatculescu/php:cli-7.0 .
docker build --build-arg PHP_MAJOR_VERSION=7.1 -t cdatculescu/php:cli-7.1 .
docker build --build-arg PHP_MAJOR_VERSION=7.2 -t cdatculescu/php:cli-7.2 .

docker push cdatculescu/php:cli-5.6
docker push cdatculescu/php:cli-7.0
docker push cdatculescu/php:cli-7.1
docker push cdatculescu/php:cli-7.2

