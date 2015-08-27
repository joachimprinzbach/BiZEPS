#!/bin/sh

docker create --name dciJenkinsHome dci/voljenkins
docker run -d -p 8080:8080 --name dciJenkins --volumes-from dciJenkinsHome dci/jenkins
