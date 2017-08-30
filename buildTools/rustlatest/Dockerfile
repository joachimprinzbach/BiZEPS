FROM biz/mcmatools
MAINTAINER Peter Schmid <peter.schmid@zuehlke.com>

# add rust to basic build tools image

RUN apt-get update && apt-get install -y curl \
  && cd /home/jenkins \
  && curl -f -L https://static.rust-lang.org/rustup.sh -O \
  && sh rustup.sh --disable-sudo\
  && rm rustup.sh \
  && rm -rf /var/lib/apt/lists/*
  