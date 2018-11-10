FROM php:5.6-fpm

RUN apt-get update && apt-get install -y \
  bzip2 \
  curl \
  git \
  openssh-client \
  libcurl4-openssl-dev \
  libfreetype6-dev \
  libicu-dev \
  libjpeg-dev \
  libmcrypt-dev \
  libpng-dev \
  libxml2-dev \
  libxslt1-dev 
#  php5-xdebug
#  && rm -rf /var/lib/apt/lists/*