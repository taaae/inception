#!/bin/sh
set -e

if [ ! -f /var/lib/mysql/db_setup_done_vol ]; then
    service mariadb start

    cat << EOF | mariadb
CREATE DATABASE ${MARIADB_DATABASE};
CREATE USER '${MARIADB_USER}' IDENTIFIED BY '$(cat $MARIADB_PASSWORD_FILE)';
GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$(cat $MARIADB_ROOT_PASSWORD_FILE)';
FLUSH PRIVILEGES;
EOF

    mysqladmin -u root -p"$(cat $MARIADB_ROOT_PASSWORD_FILE)" shutdown

    touch /var/lib/mysql/db_setup_done_vol # flag file to indicate setup is complete
else
    echo "Skipping one-time MariaDB setup, already completed."
fi


if [ ! -f /config_setup_done ]; then
    echo setup_not_done
    cat << EOF >> /etc/mysql/my.cnf

[mysqld]
bind-address = 0.0.0.0
EOF
    touch /config_setup_done
fi

mkdir -p /run/mysqld

exec "$@"
