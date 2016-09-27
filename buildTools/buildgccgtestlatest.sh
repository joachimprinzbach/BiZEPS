#!/bin/sh

# Add google test lilb to g++ image
# -t defines the name for the created images

./buildgcclatest.sh
docker build -t biz/gccgtestlatest ./gccgtestlatest
