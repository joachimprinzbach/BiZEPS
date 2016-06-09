#!/bin/sh

# Clone the project on the host and not within the dockerfile
# This keeps the generated docker image smaller
echo "Download resources"
git clone git://github.com/raspberrypi/tools.git --depth 1 ./src
mkdir -p ./Dockerfiles/workspace/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/
cp -rf ./src/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/ ./Dockerfiles/workspace/arm-bcm2708/

# Builds a cross compiler for raspberry pi
# -t defines the name for the created images
echo "Create docker image"
docker build -t biz/raspislave ./Dockerfiles

# Remove the resources from the host after the docker image has been built
echo "Remove resources"
rm -rf ./src
rm -rf ./Dockerfiles/workspace
