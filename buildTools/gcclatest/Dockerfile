FROM biz/mcmatools
MAINTAINER Peter Schmid <peter.schmid@zuehlke.com>

# add g++ to basic build tools image

RUN apt-get update && apt-get install -y \
  g++ \
  && rm -rf /var/lib/apt/lists/*
