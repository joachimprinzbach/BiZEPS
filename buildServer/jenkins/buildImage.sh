#!/bin/sh

# Builds the required images required for BiZEPS from the Dockerfiles
# -t defines the name for the created images

docker build -t biz/jenkinsuser ./user
docker build -t biz/jenkinshome ./home --build-arg DOCKER_SERVER_URL=tcp://192.168.99.100:2376
docker build -t biz/jenkins ./master
docker build -t biz/jenkinsslave ./slave
