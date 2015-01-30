FROM ykode/ubuntu:azure

MAINTAINER Didiet Noor <didiet@ykode.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && apt-get -y install php5 php5-fpm php5-gd php5-ldap \
    php5-sqlite php5-pgsql php-pear php5-mysql \
    php5-mcrypt php5-xmlrpc \
    php5-curl php5-cli php5-apcu && \
    apt-get -y clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sed -i '/daemonize /c \
  daemonize = no' /etc/php5/fpm/php-fpm.conf && \
  sed -i '/^listen /c \
  listen = 0.0.0.0:9000' /etc/php5/fpm/pool.d/www.conf && \
  sed -i 's/^listen.allowed_clients/;listen.allowed_clients/' /etc/php5/fpm/pool.d/www.conf && \
  sed -i 's/upload_max_filesize\ =\ 2M/upload_max_filesize\ =\ 20M/g' /etc/php5/fpm/php.ini

EXPOSE 9000


