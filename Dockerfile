FROM php:7.1.30-fpm

LABEL maintainer="yansongda <me@yansongda.cn>"

WORKDIR /www

ENV TZ=Asia/Shanghai

RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libbz2-dev libmcrypt-dev libmemcached-dev libssh-dev \
  && pecl install -o -f mongodb swoole redis memcached \
  && docker-php-ext-install opcache bcmath bz2 gd iconv mcrypt mysqli pdo pdo_mysql zip \
  && docker-php-ext-enable opcache redis memcached mongodb swoole \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/pear \
  && curl https://dl.laravel-china.org/composer.phar -o /usr/local/bin/composer \
  && chmod a+x /usr/local/bin/composer \
  && composer config -g repo.packagist composer https://packagist.laravel-china.org \
  && composer selfupdate \
  && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY sources.list /etc/apt/sources.list
COPY php.ini /usr/local/etc/php/conf.d/
