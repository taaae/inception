#!/bin/sh

if [ ! -f /var/www/html/wp-config.php ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
	mkdir -p /var/www/html
    cd /var/www/html
    wp core download --allow-root
    wp config create --allow-root --dbuser=$WORDPRESS_DB_USER --dbhost=$WORDPRESS_DB_HOST --dbname=$WORDPRESS_DB_NAME --dbpass=$(cat $WORDPRESS_DB_PASSWORD_FILE)
    wp core install --allow-root --url=$WORDPRESS_URL --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_email=$WORDPRESS_ADMIN_EMAIL --admin_password=$(cat $WORDPRESS_ADMIN_PASSWORD_FILE)
    wp user create --allow-root $WORDPRESS_USER_LOGIN $WORDPRESS_USER_EMAIL --user_pass=$(cat $WORDPRESS_USER_PASSWORD_FILE)
fi

exec "$@"
