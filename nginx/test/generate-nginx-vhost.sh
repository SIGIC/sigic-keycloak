#!/bin/bash

DOMAIN=$1
shift
ALLOWED_ORIGINS=("$@")  # Resto de parámetros como orígenes permitidos

if [ -z "$DOMAIN" ] || [ ${#ALLOWED_ORIGINS[@]} -eq 0 ]; then
  echo "Uso: $0 dominio.com https://origen1.com [https://origen2.com ...]"
  exit 1
fi

TEMPLATE="./nginx/templates/nginx-vhost.conf.template"
OUTPUT="./nginx/vhost.d/${DOMAIN}"

# Genera los bloques if
ORIGIN_CONDITIONS=""
for ORIGIN in "${ALLOWED_ORIGINS[@]}"; do
  ESCAPED_ORIGIN=$(echo "$ORIGIN" | sed 's/\./\\./g')
  ORIGIN_CONDITIONS+="if (\$http_origin ~* ($ESCAPED_ORIGIN)) {\n    set \$allowed_origin \$http_origin;\n}\n"
done

# Sustituye el marcador en la plantilla
export ORIGIN_CONDITIONS

envsubst '$ORIGIN_CONDITIONS' < "$TEMPLATE" | \
  sed "/{{ORIGIN_CONDITIONS}}/ {
    s/{{ORIGIN_CONDITIONS}}//g
    r /dev/stdin
  }" > "$OUTPUT"

echo "✅ Archivo generado: $OUTPUT"
