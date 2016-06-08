FROM debian:jessie
MAINTAINER Dominik Ebert <doe@zuehlke.com>

#See: https://registry.hub.docker.com/u/evarga/jenkins-slave

RUN apt-get update && apt-get install -y \
  default-jre \
  git \
  openssh-server \
  python \
  && rm -rf /var/lib/apt/lists/*

# Setup a basic SSH server
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

# Add user jenkins to the image
RUN adduser --quiet jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

