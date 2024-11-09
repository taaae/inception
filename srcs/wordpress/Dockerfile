FROM debian:12.6

RUN apt update \
    && apt install -y curl php php-fpm php-mysqli

RUN echo listen = 9000 >> /etc/php/8.2/fpm/pool.d/www.conf

COPY ./setup-wordpress.sh /

EXPOSE 9000

ENTRYPOINT [ "/setup-wordpress.sh" ]

CMD ["/usr/sbin/php-fpm8.2", "-F"]
