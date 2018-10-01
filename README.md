# Magento 2 development Docker-compose scaffold
This repo hold a docker-compose base configuration for Magento 2. It's based upon MariDB stock image, nmarus/nginx-full image, stock PHP FPM 7.1 image , and use minimal customization to these by using configuration injection. Only the FPM image is customized to install required PHP extensions. This is only for development purpose. It provide PHPMyAdmin and Mailcatcher as conveniance.  It's also unsafe, password are weaks and you will face problems if you try to use it in production. DO NO USE FOR LIVE SITE.

## Why use this instead of using (insert the of name your prefered Magento docker image here)
Most Magento Docker image are monolytic or at most using an external MySQL server. This may be great if you don't need to tailor the configuration often or like to rebuild image, but I prefer to be able to tweak things easily while at the same time rely on the thinest images possible. As such, it's quite easy to switch images version, add Varnish or Pound support or add a Solar server, without having to customize a Dockerfile. Docker-compose is a simpler, more elegant solution. Use it!

## Features
* Nginx full from nmarus/nginx-full
* MariaDB 10
* PHP-FPM 7.1 with the following extensions:
	* XDebug (disable in the customized.ini file)
	* bc-math
	* gd (with freetype and jpeg support)
	* iconv
	* mcrypt
	* curl
	* dom
	* hash
	* pdo
	* pdo_mysql
	* simplexml
	* soap
	* opcache
* Redis: A fast key-value store. Configured as a memory online store for now, but support for dump on shutdown could be added easily.
* PHPMyAdmin: PHPMyAdmin is configured to allow remote connection. Use the database credentials in the following section to log onto the db server. 
* MailCatcher: Mailcatcher is a fake SMTP service which catch all mail going through and allow you to read them in a web interface. Pretty usefull to debug mail template and suchs.
* ElasticSearch: Poppular searche engine to use with third party search plugins
* Varnish: Really fast reverse proxy

## Services structure
Docker-compose use service name as hostname. You will need those while configuring
* db: MySql server (listening on port 3306)
* fpm: PHP-FPM listening on port 9000. If you need to execute PHP commands (like running n98-magerun), do it there.
* redis: Redis cache (listening on port 6379)
* mailcatcher: (accessible on port 1080 with your web brower) 
* phpmyadmin: (accessible on port 8888 with your web brower)
* nginx: listening on http (8080) and https (443)
* varnish: listening on port 80 and 6085

## Database configuration
The MySQL database configuration are passed to the MySQL instance as environment variables set inside the docker-compose.yml file. They are used to initialize the MySQL instance on the first run. Feel free to adjust them as you need. By default the root password, the regular user name, it's password AND the database are all set to "magento". AGAIN, THERE IS NO SECURITY EXPECTATIONS HERE, DO NOT USE IN PRODUCTION.

## Folder structure
* www : Put your public Magento folder there. If you want your Magento site to be able to write to the folder, you'll have to ensure the group 33 is write-enabled (www-data on debian, http on arch) on the folder. New files will be created with the www-data user on the PHP-FPM machine.
* db/init : Any scripts (SQL or sh) placed there will be ran on the first machine build. Usefull for importing a database

# Using Git Submodules
The .gitmodules file is in .gitignore. As such, unless you personalize the configuration, you should be able to simply clone this repo, add your code repo as a submodule (the www folder), and still be able to pull update from this repo without a hitch.

## Configuration customization
* Nginx virtual hosts configuration should be placed inside conf/nginx.conf.d/. You can reference fastcgi_backend upstream server to pass PHP scripts to PHP-FPM. 
* PHP configuration can be tailored by editing the fpm/custom.ini.
* FPM pool configuration is not exposed (no need for now).

## SSL Configuration
You can generate a wildcard certificate by calling generatessc.sh folder in conf/certs. Be sure to be inside this folder as it is mapped inside nginx and it will be looking for certificates there.

# Varnish HTTPS support
Varnish by itself doesn't support HTTPS. So we end-up doing the Nginx (443) -> Varnish (80) -> Nginx (8080) sandwich. No more configuration is required.

## PHP Debugging
Xdebug extension configuration is exposed in conf/xdebug.conf. By default xdebug is disable, the remote port is set to 9009 and the remote handler to dbgp. The connect_back option is enable, so ensure your IDE is allowing it.

## Adding further features
More PHP extensions can be added by customizing the dockerfile inside the FPM folder. Simply rebuild the FPM image after by running docker-compose up --build.

## TODO
* Add HTTP2 support (require to change Nginx image)
* Modularize the compose file
* More thorough documentation

## Thanks and credit
This repo is an assembly of configurations snippets grabbed all around, but mostly from PHP and MySQL docker builds. The Wordpress docker build documentation has also been very usefull helping mastering docker.  
