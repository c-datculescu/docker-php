# Basic images for php-cli and php-fpm/nginx/runit

A set of basic images used for cli/fpm applications.

# Supported versions

The currently supported php versions are:

- 5.6
- 7.0
- 7.1
- 7.2

# Docker image naming

The __cli__ images are named in the following format: __cdatculescu/php:cli-{PHP_MAJOR_VERSION}__. Example: _cdatculescu/php:cli-5.6_.

The __fpm/nginx/runit__ images are named in the following format: __cdatculescu/php:nginx-fpm-{PHP_MAJOR_VERSION}__. Example: _cdatculescu/php:nginx-fpm-5.6_.

# Additional software

Along with the image, a few additional software is included in the form of extensions:

- opcache
- curl
- json
- memcached
- mysql
- readline
- mcrypt (php < 7.2)


For additional information please consult [Sury](https://deb.sury.org/).

Also with the image comes bundled composer installed globally, with prestissimo for parralel dependency download. For more information please consult [prestissimo](https://github.com/hirak/prestissimo).

Consul template is also available for reconfiguring dynamically various needed aspects, the example that is bundled is the fpm dynamic worker allocation (please see additional operations section below).

# Additional packages

Additional packages are also bundled with the image as follows:

- ca-certificates
- apt-transport-https
- vim
- net-tools
- curl
- wget
- bc
- telnet

Some of these tools are very good for debugging various stuff, others are there for convenience (telnet, vim). Feel free to update according to your needs by forking the repository.

# Additional operations

In the case of the fpm image, assuming dynamic pools, based on the memory available, some calculations are made in order to increase the number of workers. Please note this is not necessarily what needs to go into production, and please pay attention to the way these workers are being calculated.

This function serves as a mere example of calculating dynamically the number of fpm worker processes.

# Worker processes

All worker processes for both nginx and fpm are running by default under the root user. Please adjust this to fit your needs. Running workers under root does pose security issues.
