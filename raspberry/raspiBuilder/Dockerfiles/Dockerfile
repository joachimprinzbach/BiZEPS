FROM biz/jenkinsslave
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
ENV VAR_FILE /development/vars.env
ENV TOOLCHAIN_REL_SRC_DIR=arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64

RUN mkdir -p ${TOOLCHAIN_DIR}
RUN mkdir -p ${TOOLCHAIN_DIR}src && \
    cd ${TOOLCHAIN_DIR}src && \
    git init && \
    git remote add origin git://github.com/raspberrypi/tools.git && \
    git fetch origin --depth 1 && \
    git config core.sparseCheckout true && \
    echo ${TOOLCHAIN_REL_SRC_DIR} >> .git/info/sparse-checkout && \
    git checkout master && \
    cd .. && \
    mv -f ./src/${TOOLCHAIN_REL_SRC_DIR} ${TOOLCHAIN_DIR} && \
    rm -rf ./src \

# Export common environment variables
# Export common environment variables
ENV PATH ${TOOLCHAIN_DIR}${X_TOOLCHAIN64}/bin:${PATH}
ENV CC arm-linux-gnueabihf-gcc
ENV CXX arm-linux-gnueabihf-g++

RUN touch /development/vars.env
RUN echo export PATH=${TOOLCHAIN_DIR}${X_TOOLCHAIN64}/bin/:${PATH} >> ${VAR_FILE}
RUN echo export CC=arm-linux-gnueabihf-gcc >> ${VAR_FILE}
RUN echo export CXX=arm-linux-gnueabihf-g++ >> ${VAR_FILE}

VOLUME /development

CMD ["/usr/sbin/sshd", "-D"]
