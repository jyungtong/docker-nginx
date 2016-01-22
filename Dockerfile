FROM alpine:latest
MAINTAINER Tux Tong <huntthetux@gmail.com>

COPY build-nginx.sh /tmp/

RUN chmod +x /tmp/build-nginx.sh && /tmp/build-nginx.sh

CMD nginx
