#!/bin/sh

NGINX='nginx -g daemon off'

addgroup -S nginx
adduser -s /bin/sh -G nginx -D -S nginx

if [ "${1:0:1}" = '-' ]; then
  NGINX="$NGINX $@"
elif [ "$1" != 'nginx' ] && [ ! -z "$1" ]; then
  NGINX="$@"
fi

# forward request and error logs to docker log collector
ln -sf /dev/stdout /var/log/nginx/access.log
ln -sf /dev/stderr /var/log/nginx/error.log

su -c "$NPM" nginx
