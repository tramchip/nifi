FROM openjdk:8-jre
LABEL MAINTAINER = "tram (https://www.linkedin.com/in/tram-pham)"



ARG UID=1000
ARG GID=1000
ARG NIFI_VERSION=1.9.0
ARG BASE_URL=https://archive.apache.org/dist
ARG MIRROR_BASE_URL=${MIRROR_BASE_URL:-${BASE_URL}}
ARG NIFI_BINARY_PATH=${NIFI_BINARY_PATH:-/nifi/${NIFI_VERSION}/nifi-${NIFI_VERSION}-bin.zip}
ARG NIFI_TOOLKIT_BINARY_PATH=${NIFI_TOOLKIT_BINARY_PATH:-/nifi/${NIFI_VERSION}/nifi-toolkit-${NIFI_VERSION}-bin.zip}



ENV NIFI_BASE_DIR=/opt/nifi
ENV NIFI_HOME ${NIFI_BASE_DIR}/nifi
ENV NIFI_TOOLKIT_HOME ${NIFI_BASE_DIR}/nifi-toolkit-current

ENV NIFI_PID_DIR=${NIFI_HOME}/run
ENV NIFI_LOG_DIR=${NIFI_HOME}/logs


USER root
#Nifi Web Application port
EXPOSE "9090:9090"
#NiFi web application secure port
EXPOSE 8443
#Nifi Site-to Site ports
EXPOSE 10000
#NiFi ListenHTTP processor port
EXPOSE 8082
#zookeeper client port
EXPOSE 2181
#NiFi site to site communication port
EXPOSE 2881
#NiFi cluster node protocol port
EXPOSE 2882
#Zookeeper port for monitoring NiFi nodes availability
EXPOSE 2888
#Zookeeper port for NiFi Cluster Coordinator election
EXPOSE 3888

# RUN apt-get install -y java-1.8.0-openjdk tar

# Setup NiFi user and create necessary directories
RUN groupadd -g ${GID} nifi || groupmod -n nifi `getent group ${GID} | cut -d: -f1` \
    && useradd --shell /bin/bash -u ${UID} -g ${GID} -m nifi \
    && mkdir -p ${NIFI_BASE_DIR} \
"Dockerfile" 113L, 4179C
