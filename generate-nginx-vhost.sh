#!/bin/bash

# Leer el archivo .env y obtener el valor de KC_HOSTNAME
if [ -f ".env" ]; then
  KC_HOSTNAME=$(grep -E '^KC_HOSTNAME=' .env | cut -d '=' -f2)
fi

# Usar localhost si KC_HOSTNAME no está definido o está vacío
KC_HOSTNAME=${KC_HOSTNAME:-localhost}

if [ ! -d "./nginx/vhost.d" ]; then
  mkdir -p "./nginx/vhost.d"
else
  rm -f "./nginx/vhost.d/*"
fi

TEMPLATE="./nginx/templates/nginx-vhost.conf.template"
OUTPUT="./nginx/vhost.d/${KC_HOSTNAME}"

# NO usamos envsubst para no romper las variables de nginx
cp "$TEMPLATE" "$OUTPUT"

echo "✅ Archivo generado: $OUTPUT"
