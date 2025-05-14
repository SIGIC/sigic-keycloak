#!/bin/sh

# Exit script in case of error
set -e

echo $"\n\n\n"
echo "-----------------------------------------------------"
echo "STARTING NGINX ENTRYPOINT ---------------------------"
date

# We make the config dir
mkdir -p "/certificates/$LETSENCRYPT_MODE"

echo "Creating autoissued certificates for HTTP host"
if [ ! -f "/certificates/autoissued/privkey.pem" ] || [[ $(find /certificates/autoissued/privkey.pem -mtime +365 -print) ]]; then
        echo "Autoissued certificate does not exist or is too old, we generate one"
        mkdir -p "/certificates/autoissued/"
        openssl req -x509 -nodes -days 1825 -newkey rsa:2048 -keyout "/certificates/autoissued/privkey.pem" -out "/certificates/autoissued/fullchain.pem" -subj "/CN=${KC_HOSTNAME}"
else
        echo "Autoissued certificate already exists"
fi

echo "Creating symbolic link for HTTPS certificate"
# for some reason, the ln -f flag doesn't work below...
# TODO : not DRY (reuse same scripts as docker-autoreload.sh)
rm -f /certificate_symlink
if [ -f "/certificates/$LETSENCRYPT_MODE/live/$KC_HOSTNAME/fullchain.pem" ] && [ -f "/certificates/$LETSENCRYPT_MODE/live/$KC_HOSTNAME/privkey.pem" ]; then
        echo "Certbot certificate exists, we symlink to the live cert"
        ln -sf "/certificates/$LETSENCRYPT_MODE/live/$KC_HOSTNAME" /certificate_symlink
else
        echo "Certbot certificate does not exist, we symlink to autoissued"
        ln -sf "/certificates/autoissued" /certificate_symlink
fi


defined_envs=$(printf '${%s} ' $(env | cut -d= -f1))

echo "Replacing environment variables"
envsubst "$defined_envs" < /etc/nginx/nginx.conf.envsubst > /etc/nginx/nginx.conf
envsubst "$defined_envs" < /etc/nginx/nginx.https.available.conf.envsubst > /etc/nginx/nginx.https.available.conf
envsubst "$defined_envs" < /etc/nginx/sites-enabled/geonode.conf.envsubst > /etc/nginx/sites-enabled/geonode.conf

echo "Enabling or not https configuration"
if [ -z "${KC_HOSTNAME}" ]; then
        echo "" > /etc/nginx/nginx.https.enabled.conf
else
        ln -sf /etc/nginx/nginx.https.available.conf /etc/nginx/nginx.https.enabled.conf
fi

echo "Loading nginx autoreloader"
sh /docker-autoreload.sh &

echo "-----------------------------------------------------"
echo "FINISHED NGINX ENTRYPOINT ---------------------------"
echo "-----------------------------------------------------"

# Run the CMD 
exec "$@"
