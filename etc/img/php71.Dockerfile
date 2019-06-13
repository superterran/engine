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
  gnupg2\
  imagemagick \
  && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install -j$(nproc) pdo pdo_mysql mcrypt gd xsl bcmath intl soap zip gd

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ && \
    docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) gd

RUN pecl install xdebug-2.6.0 \
    && docker-php-ext-enable xdebug

RUN echo 'memory_limit = 512M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini
RUN echo 'SMTP = smtp' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini
# Xdebug
RUN yes | pecl install xdebug \
  # https://gist.github.com/chadrien/c90927ec2d160ffea9c4
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_host=172.18.0.1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.profiler_enable_trigger=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.profiler_enable=off" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "profiler_output_dir=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.profiler_output_dir=/cachegrind" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Ioncube Loader
RUN cd /tmp \
	  && curl -o ioncube.tar.gz http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz \
    && tar -xvvzf ioncube.tar.gz \
    && mv ioncube/ioncube_loader_lin_7.1.so /usr/local/lib/php/extensions \
    && rm -Rf ioncube.tar.gz ioncube \
    && echo "zend_extension=/usr/local/lib/php/extensions/ioncube_loader_lin_7.1.so" > /usr/local/etc/php/conf.d/00_docker-php-ext-ioncube.ini

# SourceGuardian
RUN cd /tmp \
    && curl -o sourceguardian.tar.gz http://www.sourceguardian.com/loaders/download/loaders.linux-x86_64.tar.gz \
    && mkdir sourceguardian \
    && tar -xvvzf sourceguardian.tar.gz --directory ./sourceguardian \
    && ls \
    && mv sourceguardian/ixed.7.1.lin /usr/local/lib/php/extensions \
    && echo "zend_extension=/usr/local/lib/php/extensions/ixed.7.1.lin" > /usr/local/etc/php/conf.d/00_docker-php-ext-sourceguardian.ini \
    && rm -rf sourceguardian/

# Composer
RUN curl --silent --show-error https://getcomposer.org/installer | php
RUN mv /var/www/html/composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

# Node and NPM
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

# Install cli-tools
COPY ./var/cli-tools/ /cli-tools-tmp
RUN chmod +x /cli-tools-tmp/* 
RUN touch /cli-tools-tmp/superterran-engine-ignore
RUN rm /cli-tools-tmp/README.md
RUN cp /cli-tools-tmp/* /usr/bin/