FROM biz/jenkinsuser
MAINTAINER Daniel Merz <daniel.merz@zuehlke.com>

# creating the base image for jenkins master data volume 

# update
RUN apt-get update && rm -rf /var/lib/apt/lists/*

ENV JENKINS_HOME /var/jenkins_home
ARG user=jenkins
ARG group=jenkins
ARG DOCKER_SERVER_URL
ARG CERT_DIR=/var/certs/localDockerDaemon

COPY ./config.xml $JENKINS_HOME/config.xml
RUN sed -i 's@(DOCKER_SERVER_URL_PLACEHOLDER)@'"$DOCKER_SERVER_URL"'@g' $JENKINS_HOME/config.xml
RUN sed -i 's@(JENKINS_HOME_PLACEHOLDER)@'"$JENKINS_HOME"'@g' $JENKINS_HOME/config.xml
RUN chmod +r $JENKINS_HOME/config.xml
RUN chown ${user}:${group} $JENKINS_HOME/config.xml

COPY ./credentials.xml /$JENKINS_HOME/credentials.xml
RUN sed -i 's@(CERT_DIR_PLACEHOLDER)@'"$CERT_DIR"'@g' $JENKINS_HOME/credentials.xml
RUN chmod +r $JENKINS_HOME/credentials.xml
RUN chown ${user}:${group} $JENKINS_HOME/credentials.xml

VOLUME ${JENKINS_HOME}

CMD ["true"]


