FROM biz/jenkinsslave

RUN apt-get update && apt-get install -y \
  gawk wget git-core diffstat unzip texinfo \
  gcc-multilib build-essential chrpath socat \
  libsdl1.2-dev xterm cpio \
  && rm -rf /var/lib/apt/lists/*

CMD ["/usr/sbin/sshd", "-D"]
