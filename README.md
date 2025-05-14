# sigic-keycloak


# Variables de entorno

Se necesita crear un archivo .env con las siguientes variables de entorno

```bash
# KC_PROXY=edge
DOMAIN=nombre.de.dominio
KC_HOSTNAME=nombre.de.dominio
# KC_HOSTNAME_STRICT=true
# KC_HOSTNAME_STRICT_HTTPS=true
KC_PROXY_HEADERS=xforwarded
KC_HTTP_ENABLED=true
# KC_BOOTSTRAP_ADMIN_USERNAME=admin
# KC_BOOTSTRAP_ADMIN_PASSWORD=admin
JAVA_OPTS=-Xms512m -Xmx1024m

KC_DB_USERNAME=x[username]x
KC_DB_PASSWORD=x[password]x
KC_DB=postgres
KC_DB_URL_HOST=x[postgreshost]x
KC_DB_URL_DATABASE=x[databasename]x

LETSENCRYPT_MODE=x[staging|production]x
```

construir template de nginx:

```bash
chmod +x generate-nginx-vhost.sh
./generate-nginx-vhost.sh keycloak.domain.tld
```bash