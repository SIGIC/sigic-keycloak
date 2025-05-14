#!/bin/bash

# Uso: ./generate-nginx-vhost.sh mydomain.com https://frontend.example.com

DOMAIN=$1
CORS_ORIGIN=$2

# CORS_ORIGIN es el origen que se permite para las peticiones CORS, por ahora no aplica ningún cambio

if [ -z "$DOMAIN" ] || [ -z "$CORS_ORIGIN" ]; then
  echo "Uso: $0 dominio.com https://origen-cors.com|*"
  exit 1
fi

if [ ! -d "./nginx/vhost.d" ]; then
  mkdir -p "./nginx/vhost.d"
fi

TEMPLATE="./nginx/templates/nginx-vhost.conf.template"
OUTPUT="./nginx/vhost.d/${DOMAIN}"

export CORS_ORIGIN

envsubst < "$TEMPLATE" > "$OUTPUT"

echo "✅ Archivo generado: $OUTPUT"
