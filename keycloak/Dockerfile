FROM quay.io/keycloak/keycloak:26.3.1

USER root

# Copia el themes personalizado al directorio de temas
COPY themes/sigic /opt/keycloak/themes/sigic
COPY providers/keycloak-orcid.jar /opt/keycloak/providers/

# Realiza el build de Keycloak (requiere JAVA_OPTS y config ready)
RUN /opt/keycloak/bin/kc.sh build

USER keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]