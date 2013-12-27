FROM ubuntu:12.04

MAINTAINER Anderson Müller version: 1.0

ENV DEBIAN_FRONTEND noninteractive

RUN \
  echo "export HOME=/root" > /.profile ;\
  echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90forceyes ;\
  echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup ;\
  echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache ;\
  dpkg-divert --local --rename --add /sbin/initctl ;\
  ln -s /bin/true /sbin/initctl ;\
  echo '#!/bin/sh\nexit 101' > /usr/sbin/policy-rc.d && chmod +x /usr/sbin/policy-rc.d ;\
  echo 'deb http://archive.ubuntu.com/ubuntu precise main universe' > /etc/apt/sources.list ;\
  apt-get update ;\
  apt-get upgrade -y ;\
  apt-get install python-software-properties ;\
  apt-get install wget ;\
  locale-gen en_US.UTF-8 ;\
# END RUN

# Ensure UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Install Supervisor
RUN \
    apt-get install supervisor ;\
    mkdir -p /var/log/supervisor ;\
# END RUN

# Install SSHD
RUN \
    apt-get install openssh-server ;\
    ssh-keygen -f /root/.ssh/id_rsa -N "" >/dev/null ;\
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys ;\
    mkdir /var/run/sshd ;\
    echo "root:root" | chpasswd ;\
# END RUN

# Setup Supervisor
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Clean packages
RUN \
    apt-get clean ;\
    rm -rf /var/lib/apt/lists/* ;\
# END RUN

EXPOSE 22

CMD ["/usr/bin/supervisord", "-n"]
