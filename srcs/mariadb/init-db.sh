#!/bin/sh
set -e

if [ ! -f /db_setup_done ]; then
    service mariadb start

    cat << EOF | mariadb
CREATE DATABASE ${MARIADB_DATABASE};
CREATE USER '${MARIADB_USER}' IDENTIFIED BY '$(cat $MARIADB_PASSWORD_FILE)';
GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$(cat $MARIADB_ROOT_PASSWORD_FILE)';
FLUSH PRIVILEGES;
EOF

    cat << EOF >> /etc/mysql/my.cnf

[mysqld]
bind-address = 0.0.0.0
EOF

    mysqladmin -u root -p"$(cat $MARIADB_ROOT_PASSWORD_FILE)" shutdown

    touch /db_setup_done # flag file to indicate setup is complete
else
    echo "Skipping one-time MariaDB setup, already completed."
fi

exec "$@"
