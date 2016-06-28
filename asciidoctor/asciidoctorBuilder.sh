#!/bin/sh

# Builds a cross compiler for raspberry pi
# -t defines the name for the created images
docker build -t biz/asciidoctor ./Dockerfile

# docker run -ti --rm -v ${PWD}:/documents biz/asciidoctor /bin/bash
