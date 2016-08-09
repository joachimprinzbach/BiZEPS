#!/bin/sh

# Builds the required images required for BiZEPS from the Dockerfiles
# -t defines the name for the created images

docker build -t biz/jenkins ./master
docker build -t biz/jenkinsslave ./slave
