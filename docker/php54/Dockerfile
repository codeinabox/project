FROM ubuntu:12.04

MAINTAINER Anderson Müller version: 1.0

ENV DEBIAN_FRONTEND noninteractive

# Update packages
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
    echo "deb http://archive.ubuntu.com/ubuntu precise main restricted multiverse" >> /etc/apt/sources.list && \
    echo "deb http://ppa.launchpad.net/ondrej/php5-oldstable/ubuntu precise main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y

# Install Apache
RUN apt-get install -y --force-yes \
    apache2-mpm-worker \
    libapache2-mod-fastcgi

# Install PHP and extensions
RUN apt-get install -y --force-yes \
    php5-fpm \
    php5-cli \
    php-apc \
    php-pear \
    php5-curl \
    php5-intl \
    php5-mcrypt \
    php5-imagick \
    php5-xsl

RUN sed -i -e 's/^listen =.*/listen = \/tmp\/php5-fpm.sock/' /etc/php5/fpm/pool.d/www.conf

# Setup Apache
RUN a2enmod \
    rewrite \
    actions \
    fastcgi \
    alias

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

ADD ./php5-fcgi.conf /etc/apache2/conf.d/php5-fcgi.conf

# Clean packages
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ADD ./start.sh /usr/local/bin/start
RUN chmod +x /usr/local/bin/start

VOLUME ["/var/www"]

EXPOSE 80

CMD ["/usr/local/bin/start"]
