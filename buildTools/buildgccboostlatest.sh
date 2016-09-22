#!/bin/sh

# Add boost lilb to g++ image
# -t defines the name for the created images

./buildgcclatest.sh
docker build -t biz/gccboostlatest ./gccboostlatest
