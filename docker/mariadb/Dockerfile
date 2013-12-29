FROM amuller/base

MAINTAINER Anderson Müller version: 1.0

# Add packages
RUN \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db ;\
    add-apt-repository 'deb http://mirror.jmu.edu/pub/mariadb/repo/5.5/ubuntu precise main' ;\
    apt-get update ;\
    apt-get upgrade -y ;\
# END RUN

# Make MariaDB happy with the docker environment
RUN cat /proc/mounts > /etc/mtab

# Install MariaDB
RUN apt-get install \
    mariadb-server \
    expect

# Setup Supervisor
ADD ./supervisord.conf /etc/supervisor/conf.d/mariadb.conf

# Setup MariaDB
ENV DB_PASS root
# Add config
ADD ./my.cnf /etc/mysql/my.cnf

#RUN \
#    sed -i -e 's/^bind-address/#bind-address/' /etc/mysql/my.cnf ;\
#    chmod a+w /tmp ;\
# END RUN

ADD ./secure.sh /usr/bin/mariadb-secure
ADD ./password.sh /usr/bin/mariadb-password
ADD ./start.sh /usr/bin/mariadb-start

# Clean packages
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME ["/var/lib/mysql"]

EXPOSE 3306