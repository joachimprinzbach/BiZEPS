#!/bin/sh

docker create --name dciVolJenkins dci/voljenkins
docker run -d -p 80:8080 --name dciJenkins --volumes-from dciVolJenkins dci/jenkins
