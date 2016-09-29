#!/bin/sh

# Add google test lib to g++ image
# -t defines the name for the created images

docker build -t biz/gccgtestlatest .
