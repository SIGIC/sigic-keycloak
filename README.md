# sigic-keycloak


# Variables de entorno

Se necesita crear un archivo .env con las siguientes variables de entorno, con los
valores adecuados de conexión a la base de datos, las opciones de java son opcionales.

HTTPS_METHOD=noredirect es necesario descomentarlo para ejecutar solo la primera vez 
para poder generar el primer certificado ssl de letsencrypt. 

las variables KC_BOOTSTRAP_ADMIN_USERNAME y KC_BOOTSTRAP_ADMIN_PASSWORD solo deben 
definirse en el primer inicio y son necesarias para generar el usuario y password inicial


```bash
KC_HOSTNAME=iam.nombre.de.dominio
JAVA_OPTS=-Xms512m -Xmx1024m
KC_DB_USERNAME=x[username]x
KC_DB_PASSWORD=x[password]x
KC_DB=postgres
KC_DB_URL_HOST=x[postgreshost]x
KC_DB_URL_DATABASE=x[databasename]x
# HTTPS_METHOD=noredirect
# KC_BOOTSTRAP_ADMIN_USERNAME=admin
# KC_BOOTSTRAP_ADMIN_PASSWORD=admin123
```

construir template de nginx:

```bash
chmod +x generate-nginx-vhost.sh
./generate-nginx-vhost.sh keycloak.domain.tld
```bash