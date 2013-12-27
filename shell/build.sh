#!/usr/bin/env bash
docker build -t amuller/base /vagrant/docker/base/.
docker build -t amuller/mariadb /vagrant/docker/mariadb/.
docker build -t amuller/php /vagrant/docker/php/.
