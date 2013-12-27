#!/usr/bin/env bash
docker run -d -p 221:22 -p 3306:3306 -v "/vagrant/data:/var/data:rw" -name mariadb amuller/mariadb
docker run -d -link mariadb:db -p 222:22 -p 80:80 -v "/vagrant/www:/var/www:rw" -name php amuller/php
