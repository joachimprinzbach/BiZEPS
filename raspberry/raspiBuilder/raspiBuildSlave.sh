#!/bin/sh

# Clone the project on the host and not within the dockerfile
# This keeps the generated docker image smaller
if true; then
  echo
  echo "PREPARE: Download resources for docker image"
  echo "--------------------------------------------"
  # Download only latest commit without history, checkout only the interesting folder with the toolchain
  TOOLCHAIN_REL_SRC_DIR=arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64
  mkdir ./src && cd ./src
  git init
  git remote add origin git://github.com/raspberrypi/tools.git
  git fetch origin --depth 1
  git config core.sparseCheckout true
  echo ${TOOLCHAIN_REL_SRC_DIR} >> .git/info/sparse-checkout
  git checkout master
  cd ..
  mkdir -p ./Dockerfiles/workspace/
  mv -f ./src/${TOOLCHAIN_REL_SRC_DIR} ./Dockerfiles/workspace/
  rm -rf ./src
fi

# Builds a cross compiler for raspberry pi
# -t defines the name for the created images
if true; then
  echo
  echo "EXECUTE: Create docker image"
  echo "----------------------------"
  docker build -t biz/raspislave ./Dockerfiles
fi

# Remove the resources from the host after the docker image has been built
if true; then
  echo
  echo "WRAP UP: Remove no more used resources"
  echo "--------------------------------------"
  rm -rf ./Dockerfiles/workspace
fi

echo
echo "----"
echo "DONE"

