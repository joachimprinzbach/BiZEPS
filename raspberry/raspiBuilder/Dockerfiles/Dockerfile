FROM dci/jenkinsslave
MAINTAINER Dominik Ebert <doe@zuehlke.com>

ENV X_TOOLCHAIN64 gcc-linaro-arm-linux-gnueabihf-raspbian-x64
ENV TOOLCHAIN_DIR /development/toolChains/
ENV PATH ${TOOLCHAIN_DIR}${X_TOOLCHAIN64}/bin/:${PATH}

RUN apt-get update && apt-get install -y \
  make \
  && rm -rf /var/lib/apt/lists/*
  
# Install cross toolchain to specified tool chain directory
RUN mkdir -p $TOOLCHAIN_DIR
COPY ./workspace/arm-bcm2708/${X_TOOLCHAIN64}/ ${TOOLCHAIN_DIR}${X_TOOLCHAIN64}/

VOLUME /development
