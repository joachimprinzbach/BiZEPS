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
ENV TOOLCHAIN_DIR /development/toolChain/
ENV PATH ${TOOLCHAIN_DIR}${X_TOOLCHAIN64}/bin/:${PATH}

RUN mkdir -p $TOOLCHAIN_DIR
COPY ./workspace/arm-bcm2708/${X_TOOLCHAIN64}/ ${TOOLCHAIN_DIR}${X_TOOLCHAIN64}/

VOLUME /development

CMD ["/usr/sbin/sshd", "-D"]

# Export common environment variables
USER jenkins
RUN touch /development/vars.env
RUN echo export CC arm-linux-gnueabihf-gcc >> /development/vars.env
RUN echo export CXX arm-linux-gnueabihf-g++ >> /development/vars.env
