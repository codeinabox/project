FROM amuller/base

MAINTAINER Anderson Müller version: 1.0

# Add packages
RUN \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db ;\
    add-apt-repository 'deb http://mirror.jmu.edu/pub/mariadb/repo/5.5/ubuntu precise main' ;\
    apt-get update ;\
    apt-get upgrade -y ;\
# END RUN

# Install MariaDB
RUN apt-get install \
    mariadb-server

# Setup Supervisor
ADD ./supervisord.conf /etc/supervisor/conf.d/mariadb.conf

# Setup MariaDB
RUN \
    sed -i -e 's/^datadir\s*=.*/datadir = \/var\/data/' /etc/mysql/my.cnf ;\
    sed -i -e 's/^bind-address/#bind-address/' /etc/mysql/my.cnf ;\
    chmod a+w /tmp ;\
# END RUN

# Clean packages
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME ["/var/data"]

EXPOSE 3306