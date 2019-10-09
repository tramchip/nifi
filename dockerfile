
RUN  echo "$(curl ${BASE_URL}/${NIFI_BINARY_PATH}.sha256) *${NIFI_BASE_DIR}/nifi-${NIFI_VERSION}-bin.zip" | sha256sum -c - \
    && unzip ${NIFI_BASE_DIR}/nifi-${NIFI_VERSION}-bin.zip -d ${NIFI_BASE_DIR} \
    && rm ${NIFI_BASE_DIR}/nifi-${NIFI_VERSION}-bin.zip \
    && mv ${NIFI_BASE_DIR}/nifi-${NIFI_VERSION} ${NIFI_HOME} \
    && mkdir -p ${NIFI_HOME}/conf \
    && mkdir -p ${NIFI_HOME}/database_repository \
    && mkdir -p ${NIFI_HOME}/flowfile_repository \
    && mkdir -p ${NIFI_HOME}/content_repository \
    && cd ${NIFI_HOME}/content_repository \
    && mv ${NIFI_HOME}/content_repository /dev/nvme1n1 /mnt/nifi_content \
    && mkdir -p ${NIFI_HOME}/provenance_repository \
    && mv ${NIFI_HOME}/provenance_repository /dev/nvme2n1 /mnt/nifi_prov \
    && mkdir -p ${NIFI_HOME}/state \
    && mkdir -p ${NIFI_LOG_DIR} \
    && ln -s ${NIFI_HOME} ${NIFI_BASE_DIR}/nifi-${NIFI_VERSION}


VOLUME ${NIFI_LOG_DIR} \
    ${NIFI_HOME}/conf \
    ${NIFI_HOME}/database_repository \
    ${NIFI_HOME}/flowfile_repository \
    /dev/nvme1n1 /mnt/nifi_content \
    /dev/nvme2n1 /mnt/nifi_prov \
    ${NIFI_HOME}/state

# Clear nifi-env.sh in favour of configuring all environment variables in the Dockerfile
RUN echo "#!/bin/sh\n" > $NIFI_HOME/bin/nifi-env.sh



WORKDIR ${NIFI_HOME}

COPY       start_nifi.sh /${NIFI_HOME}/
RUN        chmod +x ./start_nifi.sh

# Apply configuration and start NiFi
#
# We need to use the exec form to avoid running our command in a subshell and omitting signals,
# thus being unable to shut down gracefully:
# https://docs.docker.com/engine/reference/builder/#entrypoint
#
# Also we need to use relative path, because the exec form does not invoke a command shell,
# thus normal shell processing does not happen:
# https://docs.docker.com/engine/reference/builder/#exec-form-entrypoint-example
ENTRYPOINT ["../scripts/start.sh"]
CMD        ./start_nifi.sh



