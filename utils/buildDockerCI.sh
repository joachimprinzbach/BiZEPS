#!/bin/sh

docker build -t dci/voljenkins ../images/jenkinsVolume
docker build -t dci/jenkins ../images/jenkins
docker build -t dci/jenkinsslave ../images/jenkinsSlave
