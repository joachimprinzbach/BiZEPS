#   DockerCI
This project realizes a continuous integration build system with Docker and Jenkins.
The Jenkins master runs in a docker container.
For each build job, a Jenkins slave runs in its own container.
Each tool chain is managed in its own docker image.
The DockerCI creates and manages its tool chain images with docker files.

[TODO](doc/Tasks.md)  

[Setup](doc/Setup.md)
