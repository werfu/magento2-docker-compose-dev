FROM php:7.1-fpm
COPY customized.ini /usr/local/etc/php/conf.d/customized.ini
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libxml2-dev \
        libcurl4-openssl-dev \
	libicu-dev \
	libxslt-dev \
        curl \
        git \
        unzip
RUN docker-php-ext-install -j$(nproc) xsl 
RUN docker-php-ext-install -j$(nproc) intl 
RUN docker-php-ext-install -j$(nproc) zip 
RUN docker-php-ext-install -j$(nproc) bcmath 
RUN docker-php-ext-install -j$(nproc) iconv 
RUN docker-php-ext-install -j$(nproc) mcrypt 
RUN docker-php-ext-install -j$(nproc) curl 
RUN docker-php-ext-install -j$(nproc) dom 
RUN docker-php-ext-install -j$(nproc) hash 
RUN docker-php-ext-install -j$(nproc) pdo pdo_mysql 
RUN docker-php-ext-install -j$(nproc) simplexml 
RUN docker-php-ext-install -j$(nproc) xml 
RUN docker-php-ext-install -j$(nproc) soap
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd
RUN pecl install redis
RUN pecl install xdebug
RUN docker-php-ext-enable redis
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ssmtp
RUN php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" && php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
COPY ssmtp.conf /etc/ssmtp/ssmtp.conf
COPY revaliases /etc/ssmtp/revaliases
RUN chown www-data:www-data /var/www/html 