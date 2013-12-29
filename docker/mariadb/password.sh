#!/bin/sh

set -eu

DB_PASS=$1

# Allow the dodgy mysql_secure_installation script to find the server socket
ln -s /var/lib/mysql/mysql.sock /var/run/mysqld/mysqld.sock

# Run the installation securing script
/usr/bin/mariadb-secure "$DB_PASS"

# Finally, grant access to off-container connections
GRANT="GRANT ALL ON *.* to root@'%' IDENTIFIED BY '${DB_PASS}';\
       FLUSH PRIVILEGES;"
echo "$GRANT" | mysql -u root --password="$DB_PASS" mysql

echo "---> MariaDB root password successfully set" >&2
