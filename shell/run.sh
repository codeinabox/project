#!/usr/bin/env bash
docker run -p 221:22 -p 3306:3306 -v /vagrant/data:/var/lib/mysql -name mariadb amuller/mariadb
docker run -p 222:22 -p 80:80 -v /vagrant/www:/var/www -link mariadb:db -name php amuller/php
