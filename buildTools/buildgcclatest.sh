#!/bin/sh

# Build latest build tool image and add g++ 
# -t defines the name for the created images

docker build -t biz/mcmatools ./mcmatools
docker build -t biz/gcclatest ./gcclatest
