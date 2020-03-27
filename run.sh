#!/bin/sh

if [[ -z "${DEFAULT_CONF}" ]]; then
  echo "Error: environment variable DEFAULT_CONF not set"
  exit 1
fi

echo "${DEFAULT_CONF}" > /etc/nginx/conf.d/default.conf
echo "Will run nginx using this /etc/nginx/conf.d/default.conf:"
cat /etc/nginx/conf.d/default.conf
echo
exec nginx -g "daemon off;"