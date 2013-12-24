#!/usr/bin/env bash
chmod -R 755 /var/www
chown -R www-data:www-data /var/www

/usr/sbin/php5-fpm -D && /usr/sbin/apache2 -D FOREGROUND
