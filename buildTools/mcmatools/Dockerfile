FROM biz/jenkinsslave
MAINTAINER Peter Schmid <peter.schmid@zuehlke.com>

# add basic build tools make cmale and auto tools to jenkins slave

RUN apt-get update && apt-get install -y \
  make \
  cmake \
  automake \
  && rm -rf /var/lib/apt/lists/*
