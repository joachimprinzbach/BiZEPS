[home](01_BiZEPS_Introduction.md)

#   Current State of BiZEPS
- Basic setup is up and running
  - Docker images can be generated from Dockerfiles
  - BiZEPS can be started with a script
  - Jenkins master and slave is running
  - HelloWorld.c from Github is compiling
  - Amazon Cloud
  - Sources available on Stash

#   What Next?
- Soon available on Zuehlke open source project space (Github)
- All who are setting up a tool chain are invited to contribute
- BiZEPS needs ready to use tool chains!
- Define the BiZEPS build approach
  - make, cmake ...?
  - Do not manage build information in the build job description
  - Add build related information to VCS
  - Meta files for parametrized builds?
- Build the Docker images on the build server
- Strategy for continuous deployment of the build system

#   Open Issues
- Currently no Windows containers possible
  - Decision: Windows or Linux, not both!
  - Only possible on Windows Azure (Windows Server)
  - Microsoft and Docker community are working on it
- Docker uses the kernel from the host system
  - What happens if the host is updated?
  - Generate VMs for the Docker host
- Docker releases
  - Can images be reused with a new Docker deamon version?
- Private Docker repository currently not yet available @Zuehlke
  - Setup a private repository
  - Go for open source, push the repositories to Docker hub
- Docker vs. Rocket
  - Once upon a time, Rocker split away from Docker
  - More open source
  - Less straight forward and less comfort
- Reproduce a docker image out of a docker file after several years
  - Docker file defines packages to install
  - If the package repository disappears, the image cannot be reproduced!
  - Setup an own package and binary repository (e.g. Archiva)
