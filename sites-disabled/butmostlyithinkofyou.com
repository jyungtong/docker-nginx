server {
  #listen [::]:80;
  listen 80;

  # listen on the www host
  server_name www.butmostlyithinkofyou.com;

  return 301 $scheme://butmostlyithinkofyou.com$request_uri;
}

server {
  # listen [::]:80 accept_filter=httpready; # for FreeBSD
  # listen 80 accept_filter=httpready; # for FreeBSD
  # listen [::]:80 deferred; # for Linux
  # listen 80 deferred; # for Linux
  #listen [::]:80;
  listen 80;

  server_name butmostlyithinkofyou.com;

  root /sites/butmostlyithinkofyou.com;

  charset utf-8;

  # Custom 404 page
  error_page 404 /404.html;

  # Include the basic h5bp config set
  include h5bp/basic.conf;
}
