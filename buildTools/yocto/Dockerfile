FROM biz/jenkinsslave

# Install required packages
RUN apt-get update && apt-get install -y \
  gawk wget git-core diffstat unzip texinfo \
  gcc-multilib build-essential chrpath socat \
  libsdl1.2-dev xterm cpio \
  && rm -rf /var/lib/apt/lists/*

# Set locale to en_US.UTF-8
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

CMD ["/usr/sbin/sshd", "-D"]
