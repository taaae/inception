# FROM debian:12.6
FROM debian:bullseye

# RUN apk update \
#     && apk add curl --no-cache
    # download and unzip wordpress
    # && curl -o wordpress.tar.gz -fL https://wordpress.org/wordpress-6.6.2.tar.gz \
    # && tar -xvzf wordpress.tar.gz \
    # use environmental variables
    # && cat /wordpress/wp-config-sample.php \
    # | sed "s/database_name_here/${WORDPRESS_DB_NAME}/" \
    # | sed "s/username_here/${WORDPRESS_DB_USER}/" \
    # | sed "s/password_here/$(cat $WORDPRESS_DB_PASSWORD_FILE)/" \
    # | sed "s/password_here/${WORDPRESS_DB_PASSWORD}/" \
    # | sed "s/localhost/${WORDPRESS_DB_HOST}/" \
    # > /wordpress/wp-config.php \
    # apply changes to wp-config-sample.php
    # && cat /wordpress/wp-config.php \
    # > /wordpress/wp-config-sample.php \
    # generate wordpress keys
    # && cat /wordpress/wp-config-sample.php \
    # | sed "/AUTH_KEY/d" \
    # | sed "/SECURE_AUTH_KEY/d" \
    # | sed "/LOGGED_IN_KEY/d" \
    # | sed "/NONCE_KEY/d" \
    # | sed "/AUTH_SALT/d" \
    # | sed "/SECURE_AUTH_SALT/d" \
    # | sed "/LOGGED_IN_SALT/d" \
    # | sed "/NONCE_SALT/d" \
    # > /wordpress/wp-config.php \
    # && curl https://api.wordpress.org/secret-key/1.1/salt/ >> /wordpress/wp-config.php \
    # cleanup and move to the appropriate directory
    # && rm /wordpress/wp-config-sample.php wordpress.tar.gz \
    # && mkdir -p /var/www \
    # && mv /wordpress /var/www/html

RUN apt update \
    && apt install -y curl php php-fpm php-mysqli

# RUN echo listen = 9000 >> /etc/php/8.2/fpm/pool.d/www.conf
RUN echo listen = 9000 >> /etc/php/7.4/fpm/pool.d/www.conf

COPY ./setup-wordpress.sh /

EXPOSE 9000

ENTRYPOINT [ "/setup-wordpress.sh" ]

# CMD ["/usr/sbin/php-fpm8.2", "-F"]

# Socket
RUN mkdir -p /run/php

CMD ["/usr/sbin/php-fpm7.4", "-F"]
