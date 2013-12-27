FROM amuller/base

MAINTAINER Anderson Müller version: 1.0

# Add packages
RUN \
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db ;\
    add-apt-repository ppa:ondrej/apache2 ;\
    add-apt-repository ppa:ondrej/php5 ;\
    apt-get update ;\
    apt-get upgrade -y ;\
# END RUN

# Install GIT and CURL
RUN apt-get install \
    git \
    curl

# Install Apache
RUN apt-get install \
    apache2-mpm-worker \
    libapache2-mod-fastcgi

# Install PHP and extensions
RUN apt-get install \
    php5-fpm \
    php5-cli \
    php-apc \
    php-pear \
    php5-curl \
    php5-intl \
    php5-mcrypt \
    php5-imagick \
    php5-xsl

# Setup Supervisor
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/sites-available/000-default.conf

RUN a2enmod \
    headers \
    rewrite \
    actions \
    fastcgi \
    alias \
    vhost_alias

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

ADD ./php5-fcgi.conf /etc/apache2/conf.d/php5-fcgi.conf

RUN chmod -R 755 /var/www && chown -Rf www-data:www-data /var/www

# Setup PHP
RUN sed -i -e 's/^listen =.*/listen = \/var\/run\/php5-fpm.sock/' /etc/php5/fpm/pool.d/www.conf
#RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini
#RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf
#RUN find /etc/php5/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

# Clean packages
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME ["/var/www"]

EXPOSE 80