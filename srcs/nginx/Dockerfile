FROM alpine:3.19

RUN apk update && apk add nginx  \
    # forward logs to stdout and stderr
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log 

CMD [ "nginx", "-g", "daemon off;" ]
