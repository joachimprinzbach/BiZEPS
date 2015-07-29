FROM debian:jessie
MAINTAINER Dominik Ebert <doe@zuelhke.com>

#See: https://registry.hub.docker.com/u/evarga/jenkins-slave

# install SSH server
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd

# install JDK
RUN apt-get update && apt-get install -y default-jdk

# Add user jenkins to the image
RUN adduser --quiet jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

CMD ["/usr/sbin/sshd"]
