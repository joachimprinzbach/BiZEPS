#!/bin/sh

# Creates a volume container for the home directory of jenkins server with the specified name
# The volume container has not to be started
docker create -v /var/jenkins_home --name bizJenkinsHome biz/jenkinsuser

# Create a container for the certificates and add them if they are available
# Add TLS certificates for the docker daemon communication if available
# For docker machine, the certificates are located at '<home>/.docker/machine/certs'
CERT_DIR_SRC=./masterCerts/certs
CERT_DIR_DST=/var/certs/localDockerDaemon
docker create --name bizJenkinsCerts biz/jenkinscerts
if [ -d ${CERT_DIR_SRC} ]; then
  docker cp ${CERT_DIR_SRC}/ca.pem bizJenkinsCerts:${CERT_DIR_DST}
  docker cp ${CERT_DIR_SRC}/ca-key.pem bizJenkinsCerts:${CERT_DIR_DST}
  docker cp ${CERT_DIR_SRC}/cert.pem bizJenkinsCerts:${CERT_DIR_DST}
  docker cp ${CERT_DIR_SRC}/key.pem bizJenkinsCerts:${CERT_DIR_DST}
fi

# Creates and starts the Jenkins master container
# -d for dispatched mode (run in background)
# -p for linked port on the host
# --name of the container
# --volumes-from container with the volumes to mount
# and biz/jenkins is the image to be used
docker run -d -p 8080:8080 --name bizJenkins --volumes-from bizJenkinsCerts --volumes-from bizJenkinsHome biz/jenkins
