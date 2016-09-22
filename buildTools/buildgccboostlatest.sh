#!/bin/sh

# Build latest GCC image
# -t defines the name for the created images

docker build -t biz/gcclatest ./gcclatest
docker build -t biz/gccboostlatest ./gccboostlatest
