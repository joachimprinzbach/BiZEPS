#!/bin/sh

# Creates a volume container
docker create --name bizRaspiBuilderVolume biz/raspislave

# Creates and starts the Jenkins master container
# -d for dispatched mode (run in background)
# --name of the container
# --volumes-from container with the volumes to mount
# and dci/jenkins is the image to be used
docker run -d --name bizRaspiBuilder --volumes-from bizRaspiBuilderVolume biz/raspislave
