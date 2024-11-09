FROM debian:12.6

RUN apt update \
    && apt -y install mariadb-server \ 
    && apt -y install mariadb-client

COPY ./init-db.sh /init-db.sh

EXPOSE 3306

ENTRYPOINT [ "/init-db.sh" ]

CMD ["mariadbd", "--user=root"]
