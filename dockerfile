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
"Dockerfile" 112L, 4158C
