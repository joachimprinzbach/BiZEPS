##  TODO
### First draft with boot2docker on Windows
**Acceptance Criteria:**
HelloWorld-Project from git hub can be built on the DockerCI

- [jenkinsTrial](https://github.com/icebear8/jenkinsTrial) project is used
    * g++
    * python
    * git hub
- Jenkins runs in a docker container
- The build job runs in a docker container
- The docker images were created by a dockerfile
- Documentation for setup is available

**Tasks**
*DONE*

- Create Jenkins docker image with Dockerfile
- Manage Jenkins volume (jenkins_home) in a docker volume container
- Define and create Jenkins slave docker image with Dockerfile
- Define gcc/g++ docker image with Dockerfile

### Open Issues
####  Docker Volume Dependencies

If the Jenkins volume image (and the created container) are depending from the Jenkins image,
The Jenkins image cannot be deleted without removing the the volume container.
The Jenkins volume container should not depend on the Jenkins image because of the update scenarios.

When DockerCI is up and running, try to modify the dci/voljenkins to depend on debian:jessie
instead of dci/jenkins

#### Docker Volume Access Rights

The debian:jessie image was used to temporary backup the volume data on the host.
The recovery was also done with the debian image.
This lead into user access right problems, because the Jenkins image uses Jenkins as the default user
and the files in the container were only accessible by root.

Next time when data have to be backuped, try to backup and recover with dci/jenkins image container
instead of debian:jessie.

In the Jenkins Dockerfile, a user 'jenkins' is created with a specific UID,
maybe this UID should be reused for the volumes?

### Jenkins Master

- Update Jenkins plugins automatically from Dockerfile
- Install required Jenkins Docker plug ins from Dockerfile

### DockerCI Security
**Acceptance Criteria**

- Sensitive communication channels are secured

**Tasks**

- Use certificates to authenticate Jenkins Docker Plugin at the Docker API port
    * Reason: An unsecured docker port is a massive security issue.
  Attackers can gain root access, the port is public
- Use public private key pairs to identify Jenkins master at its slaves (ssh)
- Define certificate and key management
    * How to create and distribute in DockerCI environment
    * Scripts?

### DockerCI at Amazon Cloud
**Acceptance Criteria**
DockerCI runs on Amazon AWS cloud

**Tasks**

- Install script for Docker at AWS cloud
- Setup and test DockerCI at cloud

### DockerCI Tool Chains
Create additional tool chains for DockerCI (g++ for Windows, RasPi, mono ...)

### DockerCI Image Management

- Define work flow for docker images with dockerfiles
- Specify docker image version management
- How are new docker images created?
    * Would be nice if there would be a docker tool chain image similar to gcc/g
    * Not sure if it would be possible to release new docker images at DockerCI
    * If it is not working, use the 2nd docker plug-in to run docker commands on the host

### DockerCI at Development Machine
Concept for DockerCI for a single seat developer. How to integrate with IDE?
