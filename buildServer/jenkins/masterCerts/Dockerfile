# Jenkins Master Certificate Storage (volume only container)
# This image prepares a directory which holds the certificates for the communication with the docker daemon

FROM biz/jenkinsuser
MAINTAINER Dominik Ebert <doe@zuehlke.com>

ARG CERT_DIR=/var/certs/localDockerDaemon
ARG user=jenkins

# Copy the docker daemon certificates to communicate with the REST API
COPY ./certs/ca-key.pem ${CERT_DIR}/ca-key.pem
COPY ./certs/ca.pem ${CERT_DIR}/ca.pem
COPY ./certs/cert.pem ${CERT_DIR}/cert.pem
COPY ./certs/key.pem ${CERT_DIR}/key.pem

# Make sure cert permissions are set correctly
RUN chmod +r ${CERT_DIR}/ca.pem
RUN chmod +r ${CERT_DIR}/cert.pem
RUN chown -R ${user} ${CERT_DIR}

VOLUME ${CERT_DIR}

CMD ["true"]
