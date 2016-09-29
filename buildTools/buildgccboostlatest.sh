#!/bin/sh

(cd ./mcmatools && ./buildImage.sh)
(cd ./gcclatest && ./buildImage.sh)
(cd ./gccboostlatest && ./buildImage.sh)
