FROM debian:jessie
MAINTAINER Peter Schmid <peter.schmid@zuehlke.com>

# creating the base image for jenkins master and data volume to share users

# update
RUN apt-get update && rm -rf /var/lib/apt/lists/*

# create Jenkins uster
ENV JENKINS_HOME /var/jenkins_home
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=100

# Jenkins is run with user `jenkins`, uid = 1000
# If you bind mount a volume from the host or a data container, 
# ensure you use the same uid
RUN useradd -d "$JENKINS_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

VOLUME ${JENKINS_HOME}

CMD ["true"]

