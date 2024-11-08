FROM alpine:3.19

RUN apk update \
    && apk add curl --no-cache \
    # download and unzip wordpress
    && curl -o wordpress.tar.gz -fL https://wordpress.org/wordpress-6.6.2.tar.gz \
    && tar -xvzf wordpress.tar.gz \
    # use environmental variables
    && cat /wordpress/wp-config-sample.php \
    | sed "s/database_name_here/${WORDPRESS_DB_NAME}/" \
    | sed "s/username_here/${WORDPRESS_DB_USER}/" \
    # | sed "s/password_here/$(cat $WORDPRESS_DB_PASSWORD_FILE)/" \
    | sed "s/password_here/${WORDPRESS_DB_PASSWORD}/" \
    | sed "s/localhost/${WORDPRESS_DB_HOST}/" \
    > /wordpress/wp-config.php \
    # apply changes to wp-config-sample.php
    && cat /wordpress/wp-config.php \
    > /wordpress/wp-config-sample.php \
    # generate wordpress keys
    && cat /wordpress/wp-config-sample.php \
    | sed "/AUTH_KEY/d" \
    | sed "/SECURE_AUTH_KEY/d" \
    | sed "/LOGGED_IN_KEY/d" \
    | sed "/NONCE_KEY/d" \
    | sed "/AUTH_SALT/d" \
    | sed "/SECURE_AUTH_SALT/d" \
    | sed "/LOGGED_IN_SALT/d" \
    | sed "/NONCE_SALT/d" \
    > /wordpress/wp-config.php \
    && curl https://api.wordpress.org/secret-key/1.1/salt/ >> /wordpress/wp-config.php \
    # cleanup and move to the appropriate directory
    && rm /wordpress/wp-config-sample.php wordpress.tar.gz \
    && mkdir -p /var/www \
    && mv /wordpress /var/www/html

RUN apk add php-fpm --no-cache \
    && apk add php-mysqli --no-cache \
    && apk add php --no-cache

RUN echo listen = 9000 >> /etc/php82/php-fpm.d/www.conf

EXPOSE 9000

CMD ["/usr/sbin/php-fpm82", "-F"]
