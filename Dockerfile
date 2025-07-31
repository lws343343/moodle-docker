# Build argument for PHP version
ARG PHP_VERSION
FROM php:${PHP_VERSION}-apache

# Install extensions Moodle needs
RUN apt-get update \
 && apt-get install -y \
      libpng-dev libjpeg-dev libfreetype6-dev \
      libzip-dev libicu-dev libxml2-dev pkg-config \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install \
      gd mysqli intl zip xml xmlreader xmlwriter soap exif \
 && a2enmod rewrite headers

# Remove the default Apache index.html
RUN rm -f /var/www/html/index.html

# Copy in our custom configs
COPY config/apache.conf /etc/apache2/sites-available/000-default.conf
COPY config/php.ini     /usr/local/etc/php/php.ini
