#!/bin/bash

# Uso: ./generate-nginx-vhost.sh mydomain.com https://frontend.example.com

DOMAIN=$1
CORS_ORIGIN=$2

# CORS_ORIGIN es el origen que se permite para las peticiones CORS, por ahora no aplica ningún cambio

if [ -z "$DOMAIN" ]; then
  echo "Uso: $0 dominio.com"
  exit 1
fi

if [ ! -d "./nginx/vhost.d" ]; then
  mkdir -p "./nginx/vhost.d"
else
  rm -f "./nginx/vhost.d/*"
fi

TEMPLATE="./nginx/templates/nginx-vhost.conf.template"
OUTPUT="./nginx/vhost.d/${DOMAIN}"

# NO usamos envsubst para no romper las variables de nginx
cp "$TEMPLATE" "$OUTPUT"

echo "✅ Archivo generado: $OUTPUT"
