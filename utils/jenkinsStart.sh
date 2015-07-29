#!/bin/sh

docker create --name dciVolJenkins dci/voljenkins
docker run -d -p 8080:8080 --name dciJenkins --volumes-from dciVolJenkins dci/jenkins
