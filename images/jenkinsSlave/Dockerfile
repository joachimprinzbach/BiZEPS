FROM debian:jessie
MAINTAINER Dominik Ebert <doe@zuelhke.com>

#See: https://registry.hub.docker.com/u/evarga/jenkins-slave

# install JDK
RUN apt-get update && apt-get install -y default-jre

#install python
RUN apt-get update && apt-get install -y python

# install git
RUN apt-get update && apt-get install -y git

# install SSH server
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd

# Add user jenkins to the image
RUN adduser --quiet jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

CMD ["/usr/sbin/sshd"]
