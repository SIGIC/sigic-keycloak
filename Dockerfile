FROM quay.io/keycloak/keycloak:26.2.4

USER root
ENV JAVA_OPTS="-Xmx2G -Xms1G"


# Instala unzip y curl
RUN microdnf install -y unzip curl && microdnf clean all

# Copia el theme personalizado al directorio de temas
COPY keycloak/theme/sigic /opt/keycloak/themes/sigic

# Realiza el build de Keycloak (requiere JAVA_OPTS y config ready)
RUN /opt/keycloak/bin/kc.sh build

USER keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]