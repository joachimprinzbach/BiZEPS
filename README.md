#   DockerCI
This project realizes a continuous integration build system with Docker and Jenkins.
The Jenkins master runs in a docker container.
For each build job, a Jenkins slave runs in its own container.
Each tool chain is managed in its own docker image.
The DockerCI creates and manages its tool chain images with docker files.

[TODO](doc/Tasks.md)  

[Setup](doc/Setup.md)

##  Issues
### Docker Volumes
####  Dependencies
If the Jenkins volume image (and the created container) are depending from the Jenkins image,
The Jenkins image cannot be deleted without removing the the volume container.
The Jenkins volume container should not depend on the Jenkins image because of the update scenarios.

When DockerCI is up and running, try to modify the dci/voljenkins to depend on debian:jessie
instead of dci/jenkins

#### Access Rights
The debian:jessie image was used to temporary backup the volume data on the host.
The recovery was also done with the debian image.
This lead into user access right problems, because the Jenkins image uses Jenkins as the default user
and the files in the container were only accessible by root.

Next time when data have to be backuped, try to backup and recover with dci/jenkins image container
instead of debian:jessie.