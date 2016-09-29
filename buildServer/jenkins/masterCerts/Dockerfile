# Jenkins Master Certificate Storage (volume only container)
# This image prepares a directory which holds the certificates for the communication with the docker daemon

FROM biz/jenkinsuser
MAINTAINER Dominik Ebert <doe@zuehlke.com>

ARG CERT_DIR=/var/certs/localDockerDaemon
ARG user=jenkins
ARG group=jenkins

RUN mkdir -p ${CERT_DIR}
RUN chown -R ${user}:${group} ${CERT_DIR}

VOLUME ${CERT_DIR}

CMD ["true"]
