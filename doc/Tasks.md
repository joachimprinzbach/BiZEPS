#   Backlog

##  Documentation
boot2docker on OSX in Setup part one.

## BiZEPS Security
**Acceptance Criteria:**
Sensitive communication channels are secured

**Tasks**

- Use certificates to authenticate Jenkins Docker Plugin at the Docker API port
    * Reason: An unsecured docker port is a massive security issue
    * Attackers can gain root access, the port is public
- Use public private key pairs to identify Jenkins master at its slaves (ssh)
- Define certificate and key management
    * How to create and distribute in DockerCI environment
    * Scripts?

## BiZEPS Jenkins Login with public/private key
- Try to login with key pair instead of password
- Jenkins on Amazon is public to anyone in the world!

## BiZEPS Slaves at Amazon Cloud
- Use a micro instance for the master server (slow, cheap)
- Try to start the Docker slaves on other instances (fast, more expensive)
- Master should run 24 hours, slaves will run shortely
- Amazon pricing is per hour

##  Issue: Docker Volume
**Dependencies:**
If the Jenkins volume image (and the created container) are depending from the Jenkins image,
The Jenkins image cannot be deleted without removing the the volume container.
The Jenkins volume container should not depend on the Jenkins image because of the update scenarios.

Try to modify the dci/voljenkins to depend on debian:jessie instead of dci/jenkins.

Also play around with the docker file to understand volumes.
Is `mkdir /var/java_home/` and/or the `VOLUME` command on the docker volume container required?
The Jenkins Dockerfile declares this variable as volume.
If at start up the option `--volumes-from` creates the volume in the linked container
instead of the application container this would be sufficient.
If the Docker data only container has not to specify directories or volumes it could be reused for several applications.

**Access Rights:**
The debian:jessie image was used to temporary backup the volume data on the host.
The recovery was also done with the debian image.
This lead into user access right problems, because the Jenkins image uses Jenkins as the default user
and the files in the container were only accessible by root.

Next time when data have to be backuped, try to backup and recover with dci/jenkins image container
instead of debian:jessie.

In the Jenkins Dockerfile, a user 'jenkins' is created with a specific UID,
maybe this UID should be reused for the volumes?

## Jenkins Master Image
###  Initialization
- Update Jenkins plug ins automatically from Dockerfile or at first startup
- Secure Jenkins (User and Password)
- Done: Install required Jenkins Docker plug ins from Dockerfile or at first startup

###  Keep Close to Official Jenkins Dockerfile
Consider to modify current dci/jenkins Dockerfile to be similar to the official Jenkins Dockerfile.
Maybe only the base image could be replaced with Debian:jessie.
Keep in mind to stay small.
The official Jenkins Dockerfile installs JDK, WGET and CURL which is not required at runtime.

- dci/jenkins installs the default version of Java and the latest Jenkins
- It should install a specific version to support recovery scenarios and all time history support
- The official Jenkins image uses a zombie thread supervisor

## BiZEPS Tool Chains
- Define best practices for BiZEPS Dockerfiles
    * The currently used Dockerfiles are installing the latest version of a tool
    * To enable tool chain versions and tracking, a Docker image should use specific versions of the tools
    * See official Jenkins Dockerfile which installs a specific Jenkins version
- Create additional tool chains for BiZEPS (g++ for Windows, RasPi, Mono ...)

https://registry.hub.docker.com/_/jenkins/

https://github.com/jenkinsci/docker/tree/1f0d2b7d5b69aed1b0af7916ca46d35b249c1c86

## Define BiZEPS Minimal Build Job Approach
Currently BiZEPS depends on a Python script `/scripts/build.py` in the source repository.
A BiZEPS build job simply executes this script.

Check if this approach is handy enough to cover most of the tool chains.
A more portable solution could be to call a simple shell script,
the script could still call a python file from inside.
The execution of a `Makefile` is not as reusable as the Shell or the Python script.

## BiZEPS Image Management
- Define work flow for docker images with Dockerfiles
- Specify docker image version management
- How are new docker images created?
    * Would be nice if there would be a docker tool chain image similar to gcc/g++
    * Not sure if it would be possible to release new docker images at BiZEPS
    * If it is not working, use the 2nd docker plug-in to run docker commands on the host
    
**Build in Docker Tool Chain:**
BiZEPS could define an image whith Docker installed.
This image could be used as the Docker tool chain to build docker images from Dockerfiles.
This approach would match with the BiZEPS architecture and benefit from the BiZEPS advantages.
The drawback of this solution is that the created docker images somehow have to be transferred to the docker host.

**Build on Docker Host:**
Jenkins has access to the Docker API on the Docker host and could build the images on the Docker host.
This would improve the usability to create new docker images (and tool chains).
Because the docker images are created on the Docker host they are immediately accessible through the registry.
With appropriate build jobs Jenkins could build the images automatically and tag them as latest.
This solution does not benefit from the separation of the applications.
Its even worse because the build jobs are affecting the host directly
and may corrupt the whole BiZEPS if used wrong.
The benefit is an automated tool chain deployment with good usability.

## BiZEPS Meta Files
Check the possibility, usability and benefit of a BiZEPS Meta file in the project source repository.
The Meta file could define which build job (Docker image tool chain) at which version should be executed.
This could minimize the management effort in the Jenkins build job GUI.

## BiZEPS at Development Machine
Concept for BiZEPS for a single seat developer. How to integrate with IDE?
