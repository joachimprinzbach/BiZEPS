#!/bin/sh

# Builds the required images required for BiZEPS from the Dockerfiles
# -t defines the name for the created images

docker build -t dci/jenkins ../images/jenkins
docker build -t dci/voljenkins ../images/jenkinsVolume
docker build -t dci/jenkinsslave ../images/jenkinsSlave
docker build -t dci/gccslave ../images/slaveDebianGcc
