FROM dci/jenkinsslave
MAINTAINER Dominik Ebert <doe@zuehlke.com>

RUN apt-get update && apt-get install -y \
  cmake \
  make \
  && rm -rf /var/lib/apt/lists/*
  
RUN mkdir /development
RUN chown -R jenkins /development

# Install cross toolchain to specified tool chain directory
ENV X_TOOLCHAIN64 gcc-linaro-arm-linux-gnueabihf-raspbian-x64
ENV TOOLCHAIN_DIR /development/toolChains/
ENV PATH ${TOOLCHAIN_DIR}${X_TOOLCHAIN64}/bin/:${PATH}

RUN mkdir -p $TOOLCHAIN_DIR
COPY ./workspace/arm-bcm2708/${X_TOOLCHAIN64}/ ${TOOLCHAIN_DIR}${X_TOOLCHAIN64}/

# Export common environment variables
ENV CC arm-linux-gnueabihf-gcc
ENV CXX arm-linux-gnueabihf-g++

VOLUME /development

CMD ["/usr/sbin/sshd", "-D"]
