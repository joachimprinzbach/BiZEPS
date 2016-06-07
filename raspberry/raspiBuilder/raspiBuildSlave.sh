#!/bin/sh

git clone git://github.com/raspberrypi/tools.git --depth 1 ./src
mkdir -p ./Dockerfiles/workspace/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/
cp -rf ./src/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/ ./Dockerfiles/workspace/arm-bcm2708/

# Builds a cross compiler for raspberry pi
# -t defines the name for the created images
docker build -t biz/raspislave ./Dockerfiles

rm -rf ./Dockerfiles/workspace
rm -rf ./src
