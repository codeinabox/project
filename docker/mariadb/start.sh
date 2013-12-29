#!/bin/sh

set -eu

status () {
  echo "---> ${@}" >&2
}

# Allow access from outside the container
if [ ! -e /var/lib/mysql/bootstrapped ]; then
  status "Bootstrapping MariaDB installation..."

  status "Initializing MariaDB root directory at /var/lib/mysql"
  mysql_install_db

  status "Setting MariaDB root password from env var \$DB_PASS with access from anywhere!"
  sh -c 'sleep 5 && /usr/bin/mariadb-password "$DB_PASS"' &

  touch /var/lib/mysql/bootstrapped
else
  status "Starting from already-bootstrapped MariaDB installation"
fi

exec /usr/bin/mysqld_safe
