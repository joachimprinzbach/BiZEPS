FROM biz/gcclatest
MAINTAINER Peter Schmid <peter.schmid@zuehlke.com>

# add boost lib to g++ image

RUN apt-get update && apt-get install -y \
  libboost-all-dev \
  && rm -rf /var/lib/apt/lists/*
