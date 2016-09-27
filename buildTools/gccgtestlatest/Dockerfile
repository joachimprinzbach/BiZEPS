FROM biz/gcclatest
MAINTAINER Peter Schmid <peter.schmid@zuehlke.com>

# add boost lib to g++ image

RUN apt-get update && apt-get install -y \
  libgtest-dev \
  && rm -rf /var/lib/apt/lists/*

# create lib for gtest
RUN cd /usr/src/gtest && cmake CMakeLists.txt && make && cp *.a /usr/lib
