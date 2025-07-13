FROM quay.io/keycloak/keycloak:26.2.5

USER root
ARG JAVA_OPTS="-Xmx2G -Xms1G"
ARG KC_DB=postgres
ARG KC_HOSTNAME_STRICT=true

ENV JAVA_OPTS=${JAVA_OPTS}
ENV KC_DB=${KC_DB}
ENV KC_HOSTNAME_STRICT=${KC_HOSTNAME_STRICT}

# Copia el themes personalizado al directorio de temas
COPY themes/sigic /opt/keycloak/themes/sigic
COPY providers/keycloak-orcid.jar /opt/keycloak/providers/

# Realiza el build de Keycloak (requiere JAVA_OPTS y config ready)
RUN /opt/keycloak/bin/kc.sh build

USER keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]