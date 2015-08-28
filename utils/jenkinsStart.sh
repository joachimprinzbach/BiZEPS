#!/bin/sh

# Creates a volume container for the jenkins server with the specified name
# The volume container has not to be started
docker create --name dciJenkinsHome dci/voljenkins

# Creates and starts the Jenkins master container
# -d for dispatched mode (run in background)
# -p for linked port on the host
# --name of the container
# --volumes-from container with the volumes to mount
# and dci/jenkins is the image to be used
docker run -d -p 8080:8080 --name dciJenkins --volumes-from dciJenkinsHome dci/jenkins
