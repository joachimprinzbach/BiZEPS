#!/bin/sh

docker run --volumes-from dciVolJenkins -v $(pwd):/backup dci/jenkins tar cvf /backup/backup.tar /var/jenkins_home

#jenkins restore

docker create --name dciJenkinsHome dci/voljenkins
docker run --volumes-from dciJenkinsHome -v $(pwd):/backup dci/jenkins cd /var/jenkins_home && tar xvf /backup/backup.tar