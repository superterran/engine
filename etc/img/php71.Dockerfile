FROM php:7.1-fpm

RUN apt-get update && apt-get install -y \
  bzip2 \
  curl \
  git \
  zip \
  openssh-client \
  libcurl4-openssl-dev \
  libfreetype6-dev \
  libicu-dev \
  libjpeg-dev \
  libmcrypt-dev \
  libpng-dev \
  libxml2-dev \
  libxslt1-dev \
  && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install -j$(nproc) pdo pdo_mysql mcrypt gd xsl bcmath

RUN curl --silent --show-error https://getcomposer.org/installer | php
RUN mv /var/www/html/composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer