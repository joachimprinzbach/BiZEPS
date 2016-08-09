#!/bin/sh

# Creates a volume container for the jenkins server with the specified name
# The volume container has not to be started
docker create -v /var/jenkins_home --name bizJenkinsHome biz/jenkins

# Creates and starts the Jenkins master container
# -d for dispatched mode (run in background)
# -p for linked port on the host
# --name of the container
# --volumes-from container with the volumes to mount
# -v to mount the docker deamon api unix socket
# and dci/jenkins is the image to be used
docker run -d -p 8080:8080 --name bizJenkins --volumes-from bizJenkinsHome -v /var/run/docker.sock:/var/run/docker.sock biz/jenkins
