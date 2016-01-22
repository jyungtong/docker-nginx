Version
======
- [1.9.9, latest (Dockerfile)](https://github.com/tuxtong/docker-nginx/blob/master/Dockerfile)

How To Use
=========
```
docker run --rm --name docker-name \
       -v /your/source:/usr/share/nginx/html:ro -p 80:80 -p 443:443 tuxtong/nginx
```

Note
====
1. The entry default starting:
```
nginx -g daemon off
```
