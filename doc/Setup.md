#   Setup
Debian is suggested as base image by Docker documentation.

##  Jenkins
See official Jenkins image: https://github.com/jenkinsci/docker
Used Debian as base image and installed Jenkins manually.
Consider to use the official Jenkins Dockerfile and modify to use Debian and install Java.

##  Jenkins Volume
- Volume container must be created but not started
- Volume container is referenced from Jenkins
- If the volume container is removed, the Jenkins data is lost!

Why should a data container be created from a productive image instead of a small base such as scratch or busybox?
- It will not take more disk space, because of the Docker image layer characteristics 
- The image gets a chance to seed the volume with data such as default files
- The permissions and owners will be correct

See: 
- http://container-solutions.com/understanding-volumes-docker/
- http://container42.com/2014/11/18/data-only-container-madness/
- http://stackoverflow.com/questions/25845785/most-appropriate-container-for-a-data-only-container

## Jenkins Docker Slave
Use the Jenkins plug in to manage Jenkins Docker slaves.
The docker plug in starts a Docker container from a specific image and
runs the Jenkins slave in that container.
After the build step, the Docker container is removed again.
The Docker Jenkins slave image requires JRE and an SSH server.

https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin
https://registry.hub.docker.com/u/evarga/jenkins-slave/dockerfile/
