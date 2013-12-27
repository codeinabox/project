FROM amuller/base

MAINTAINER Anderson Müller version: 1.0

# Add packages
RUN \
    add-apt-repository ppa:nginx/stable ;\
    add-apt-repository ppa:ondrej/php5 ;\
    apt-get update ;\
    apt-get upgrade -y ;\
# END RUN

# Install GIT and CURL
RUN apt-get install \
    git \
    curl

# Install Nginx
RUN apt-get install \
    nginx

# Install PHP and extensions
RUN apt-get install \
    php5-fpm \
    php5-cli \
    php-apc \
    php-pear \
    php5-apcu \
    php5-curl \
    php5-intl \
    php5-mcrypt \
    php5-imagick \
    php5-xsl \
    php5-sqlite \
    php5-mysql \
    php5-memcached


# Setup Supervisor
ADD ./supervisord.conf /etc/supervisor/conf.d/php.conf

# Setup Nginx
ADD https://raw.github.com/h5bp/server-configs-nginx/master/h5bp/directive-only/x-ua-compatible.conf /etc/nginx/conf/x-ua-compatible.conf
ADD https://raw.github.com/h5bp/server-configs-nginx/master/h5bp/location/expires.conf /etc/nginx/conf/expires.conf
ADD https://raw.github.com/h5bp/server-configs-nginx/master/h5bp/location/cross-domain-fonts.conf /etc/nginx/conf/cross-domain-fonts.conf
ADD https://raw.github.com/h5bp/server-configs-nginx/master/h5bp/location/protect-system-files.conf /etc/nginx/conf/protect-system-files.conf
ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./nginx-site.conf /etc/nginx/sites-available/default
RUN sed -i -e '/access_log/d' /etc/nginx/conf/expires.conf
RUN mkdir /var/www && chown -R www-data:www-data /var/www

# Setup PHP
RUN \
    echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini ;\
    sed -i -e 's/^;daemonize\s*=\s*yes/daemonize = no/' /etc/php5/fpm/php-fpm.conf ;\
    sed -i -e 's/^listen =.*/listen = \/var\/run\/php5-fpm.sock/' /etc/php5/fpm/pool.d/www.conf ;\
# END RUN

# Download Composer
RUN \
    curl -sS https://getcomposer.org/installer | php ;\
    mv composer.phar /usr/bin/composer ;\
# END RUN

# Clean packages
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME ["/var/www"]

EXPOSE 80