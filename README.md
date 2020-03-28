# nginx-env

Just your regular nginx (nginx-alpine:latest), but one where you can inject configuration through an environment variable.

This may be of use to you if you need to run simple reverse proxies, that just need a bit of custom nginx config. No need to create a new image then, just run this one, and provide your custom nginx configuration like so:

```
export DEFAULT_CONF='server {
  listen 80;
  location / {
    proxy_pass https://example.org;
  }
}'

docker run -e "DEFAULT_CONF=$DEFAULT_CONF" ottokruse/nginx-env
```
