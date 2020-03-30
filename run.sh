#!/bin/sh -e

if [[ -z "$DEFAULT_CONF" ]]; then
    echo "Error: environment variable DEFAULT_CONF not set"
    exit 1
fi

echo
echo "${DEFAULT_CONF}" > /etc/nginx/conf.d/default.conf
echo "Will run nginx using this /etc/nginx/conf.d/default.conf:"
echo "========================================================="
cat /etc/nginx/conf.d/default.conf

for ENV_VAR in $(env)
do
    if expr "$ENV_VAR" : 'FILE_.*=.*' 1>/dev/null; then
        VAR_NAME="$(echo $ENV_VAR | awk -F'=' '{print $1}')"
        FILE_NAME="$(echo $VAR_NAME | awk -F'FILE_' '{print $2}')"
        mkdir -p /var/opt/nginx
        printenv $VAR_NAME > "/var/opt/nginx/$FILE_NAME"
        chmod 700 "/var/opt/nginx/$FILE_NAME"
    fi
done

if [[ ! -z $VAR_NAME ]]; then
  echo
  echo "Files written to /var/opt/nginx:"
  echo "================================"
  ls /var/opt/nginx
fi

echo
echo "nginx output:"
echo "============="
exec nginx -g "daemon off;"
