# nginx-env

Just your regular nginx, but one where you can inject configuration through an environment variable.

Usage:

```
export DEFAULT_CONF='server {
  listen 80;
  location /dev {
    proxy_pass https://uwsuv026oa.execute-api.us-east-1.amazonaws.com/dev;
  }
}'

docker run -e "DEFAULT_CONF=$DEFAULT_CONF" ottokruse/nginx-env
```