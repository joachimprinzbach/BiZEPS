#   DockerCI
DockerCI realizes a continuous integration build system with Docker and Jenkins.
The Jenkins master runs in a docker container.
For each build job, a Jenkins slave runs in its own container.
Each tool chain is managed in its own docker image.
The DockerCI creates and manages its tool chain images with docker files.

![DockerCI Overview](doc/Images/DockerCIOverview.jpg)



##  Status 30.07.2015
- First draft of DockerCI runs with boot2docker on Windows
- Docker Host API is currently not secured (Jenkins requires API access)
- Building the [jenkinsTrial](https://github.com/icebear8/jenkinsTrial) for Linux is possible
    * git hub
    * python
    * g++
- Dockerfiles are available for
    * Jenkins
    * Jenkins Volume
    * Jenkins Slave
    * GCC Slave

##  Documentation

[Backlog](doc/Tasks.md)

[Setup](doc/Setup.md)
