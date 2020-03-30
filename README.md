# nginx-env

Just your regular nginx (nginx:alpine), but one where you can inject configuration and files through environment variables.

This may be of use to you if you need to run simple reverse proxies, that just need a bit of custom nginx config. No need to create a new image then, just run this one, and provide your custom nginx configuration like so:

```shell
DEFAULT_CONF='server {
  listen 80;
  location / {
    proxy_pass https://example.org;
  }
}'

docker run -e DEFAULT_CONF="$DEFAULT_CONF" -p 80:80 ottokruse/nginx-env
```

# How this works

The [official nginx docker image](https://hub.docker.com/_/nginx) contains the file `/etc/nginx/conf.d/default.conf`, that can be populated with custom configuration. The value of the `DEFAULT_CONF` environment variable will be written to that file, overwriting it's prior (dummy) content, so nginx will use your content instead.

# Enabling TLS

To enable TLS, you need to provide a private key file and a certificate file to nginx. These can also be injected into the container using environment variables. To do this, supply environment variables using the following naming scheme:

`FILE_{filename}={filecontents}`

For each environment variable that is supplied like so, a file is created in /var/opt/nginx, with the supplied `{filename}` and `{filecontents}`. Then, you can refer to those files in your nginx configuration.

Complete TLS example:

```shell
# Create self signed certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/CN=www.example.com/O=My Company Name LTD./C=US' -keyout private_key -out certificate

# Create nginx configuration for TLS
DEFAULT_CONF='server {
  listen 443 ssl;
  ssl_certificate /var/opt/nginx/certificate;
  ssl_certificate_key /var/opt/nginx/private_key;
  location / {
    proxy_pass https://example.org;
  }
}'

# Run container, supplying all environment variables
docker run -e DEFAULT_CONF="$DEFAULT_CONF" -e FILE_private_key="$(cat private_key)" -e FILE_certificate="$(cat certificate)" -p 443:443 ottokruse/nginx-env
```
