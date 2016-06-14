FROM biz/jenkinsslave
MAINTAINER Dominik Ebert <doe@zuehlke.com>

# Arguments during the docker build
ARG REPO_URL=git://github.com/raspberrypi/tools.git
ARG REPO_DIR=/workspace
ARG TOOL_CHAIN_REL_PATH=arm-bcm2708/${X_TOOLCHAIN}
ARG INSTALL_PATH=/development/
ARG VAR_FILE=${INSTALL_PATH}/vars.env
ARG TOOL_CHAIN_DIR=${INSTALL_PATH}/toolChain/

# Environment variables for the image
ENV X_TOOLCHAIN gcc-linaro-arm-linux-gnueabihf-raspbian-x64
ENV PATH ${TOOL_CHAIN_DIR}${X_TOOLCHAIN}/bin:${PATH}
ENV CC arm-linux-gnueabihf-gcc
ENV CXX arm-linux-gnueabihf-g++

RUN apt-get update && apt-get install -y \
  cmake \
  make \
  && rm -rf /var/lib/apt/lists/*
  
RUN mkdir ${INSTALL_PATH}
RUN chown -R jenkins ${INSTALL_PATH}

# Install cross toolchain to specified tool chain directory
# Keep disk space during docker build process small
# Fetch from git repo, only fetch one commit and checkout only required folder
RUN mkdir -p ${TOOL_CHAIN_DIR}
RUN mkdir -p ${REPO_DIR} && \
    cd ${REPO_DIR} && \
    git init && \
    git remote add origin ${REPO_URL} && \
    git fetch origin --depth 1 && \
    git config core.sparseCheckout true && \
    echo ${TOOL_CHAIN_REL_PATH} >> .git/info/sparse-checkout && \
    git checkout master && \
    mv -f .${TOOL_CHAIN_REL_PATH} ${TOOL_CHAIN_DIR} && \
    cd / && \
    rm -rf ${REPO_DIR}

# Export common environment variables to file
RUN touch ${VAR_FILE}
RUN echo export PATH=${PATH} >> ${VAR_FILE}
RUN echo export CC=${CC} >> ${VAR_FILE}
RUN echo export CXX=${CXX} >> ${VAR_FILE}

VOLUME ${INSTALL_PATH}

CMD ["/usr/sbin/sshd", "-D"]
