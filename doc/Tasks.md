##  Backlog

####  Issue: Docker Volume
**Dependencies:**
If the Jenkins volume image (and the created container) are depending from the Jenkins image,
The Jenkins image cannot be deleted without removing the the volume container.
The Jenkins volume container should not depend on the Jenkins image because of the update scenarios.

Try to modify the dci/voljenkins to depend on debian:jessie instead of dci/jenkins. 

**Access Rights:**
The debian:jessie image was used to temporary backup the volume data on the host.
The recovery was also done with the debian image.
This lead into user access right problems, because the Jenkins image uses Jenkins as the default user
and the files in the container were only accessible by root.

Next time when data have to be backuped, try to backup and recover with dci/jenkins image container
instead of debian:jessie.

In the Jenkins Dockerfile, a user 'jenkins' is created with a specific UID,
maybe this UID should be reused for the volumes?

### Fature: Jenkins Master Initialization
**Acceptance Criteria:**
When DockerCI is installed and Jenkins is first started,
all required plug ins are installed and up to date.

- Update Jenkins plug ins automatically from Dockerfile or at first startup
- Install required Jenkins Docker plug ins from Dockerfile or at first startup
- Secure Jenkins (User and Password)

### DockerCI Security
**Acceptance Criteria:**
Sensitive communication channels are secured

**Tasks**

- Use certificates to authenticate Jenkins Docker Plugin at the Docker API port
    * Reason: An unsecured docker port is a massive security issue.
  Attackers can gain root access, the port is public
- Use public private key pairs to identify Jenkins master at its slaves (ssh)
- Define certificate and key management
    * How to create and distribute in DockerCI environment
    * Scripts?

### DockerCI at Amazon Cloud
**Acceptance Criteria:**
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
