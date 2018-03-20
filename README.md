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
- zip


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
- unzip

Some of these tools are very good for debugging various stuff, others are there for convenience (telnet, vim). Feel free to update according to your needs by forking the repository.

# Additional operations

In the case of the fpm image, assuming dynamic pools, based on the memory available, some calculations are made in order to increase the number of workers. Please note this is not necessarily what needs to go into production, and please pay attention to the way these workers are being calculated.

This function serves as a mere example of calculating dynamically the number of fpm worker processes.

# Worker processes

All worker processes for both nginx and fpm are running by default under the root user. Please adjust this to fit your needs. Running workers under root does pose security issues.

# General directory structure

The `_rootfs` folder in each directory contains a folder system that maps directly to the location of files or folders present in a linux system. This helps with managing the configurations better and avoids the chaos that generally happens when a lot of configuration files are needed for docker.

# Fpm configuration

As the image uses [sury](https://deb.sury.org/), the php configuration is no longer located in the same location as usual. In order to help with this issue (inconsistency for automated build tools), there is an extra folder located in `/etc/php/global` which is a symlink to the target php version (for example for php 5.6, `/etc/php/5.6` is a symlink to `/etc/php/global`). All the configurations can be placed in the `/etc/php/global` folder and they will be properly processed.

Additionally, by default the php socket is located in `/run/php/php-fpm.sock`.

# Nginx configuration

The nginx configuration is located in the official location, and nginx is configured to communicate with php-fpm via socket.

The home location of the fpm/nginx installation is located in `/var/www/html/`.

# Templating

The consul template structure is documented under `_rootfs/etc/consul-template`. Under the `templates` folder, the currently used templates can be found. The `consul-template.cfg` is the file controlling all the templates that need to be replaced.

# Build arguments

`PHP_MAJOR_VERSION` is used to control which version of fpm/cli gets built currently. Most of the extensions are built like this. For an example, please consult the `build.sh` from each folder.

# Running the image

`docker run cdatculescu/php:nginx-fpm-5.6 bash /run_base.sh`

# Controlling the services

- start a service `sv start fpm` `sv start nginx`
- stop a service `sv stop fpm` `sv stop nginx`
- restart a service `sv restart fpm` `sv restart nginx`

# Maintainers  
