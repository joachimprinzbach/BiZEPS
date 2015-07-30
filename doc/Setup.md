#   Building DockerCI
This section describes how DockerCI is realized as a step by step documentation.
The documentation reflects the current system state and should not be written in diary style.
If a part in DockerCI is changed the corresponding step should be updated.
The reason why the previous implementation is insufficient should also be documented.

**Reason:**
The content of this document could be used to write one or more bloc articles about DockerCI.

## Part 1: Start Using Docker
[Part 1](Setup_Part1.md)


## Creating Jenkins Master Image
Debian is suggested as base image by Docker documentation.


See official Jenkins image: https://github.com/jenkinsci/docker
Used Debian as base image and installed Jenkins manually.
Consider to use the official Jenkins Dockerfile and modify to use Debian and install Java.

##  Using Volume Container for Jenkins

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
