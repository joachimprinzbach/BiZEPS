#!/bin/sh

# Builds the required images required for BiZEPS from the Dockerfiles
# -t defines the name for the created images

docker build -t biz/jenkinsuser ./user
resultJenkinsUser=$?
docker build -t biz/jenkinshome ./home --build-arg DOCKER_SERVER_URL=tcp://192.168.99.100:2376
docker build -t biz/jenkins ./master
resultJenkinsMaster=$?
docker build -t biz/jenkinsslave ./slave
resultJenkinsSlave=$?

# Create image for the certificates
# Add TLS certificates for the docker daemon communication if available
# For docker machine, the certificates are located at '<home>/.docker/machine/certs'
CERT_DIR=./masterCerts/certs
if [ -d ${CERT_DIR} ]; then
  docker build -t biz/jenkinscerts ./masterCerts -f "./masterCerts/Dockerfile"
  resultJenkinsCerts=$?
else
  docker build -t biz/jenkinscerts ./masterCerts -f "./masterCerts/Dockerfile_noCerts"
  resultJenkinsCerts=$?
fi

echo "--------------------------------"
resultsSum=$((resultJenkinsUser + resultJenkinsMaster + resultJenkinsSlave + resultJenkinsCerts))
if [ "$resultsSum" -gt "0" ] 
then
  echo "WARNING: Not all images successfully created!!!"
  echo "JenkinsUser=$resultJenkinsUser"
  echo "JenkinsMaster=$resultJenkinsMaster"
  echo "JenkinsSlave=$resultJenkinsSlave"
  echo "JenkinsCerts=$resultJenkinsCerts"
else
  echo "All images successfully created."
fi
exit $resultsSum