#   Part 2: Create Jenkins Image
For best practices about Dockerfiles see:

- https://docs.docker.com/articles/dockerfile_best-practices
- http://jonathan.bergknoff.com/journal/building-good-docker-images

##  Use Debian as Base Image
In the BiZEPS environment requires multiple docker images to create containers from.
Some of these containers will interact with each other and some have almost no associations
to other containers.
BiZEPS should reuse the same base image (distribution) for as much images as possible.
The reasons are:

- Dockers union file system and layering approach will lead in less disk usage
- Because of Dockers caching capability the creation of derived images is faster
  than to create completely new images
- Using the same base distribution simplifies the maintenance of the containers and images

Debian distribution was chosen as base image because it is mentioned as
good base image in the Docker documentation.

##  Creating Jenkins Master Image
Jenkins provides an official image at [Docker Hub](https://registry.hub.docker.com/_/jenkins/).
The resources are managed at [Github](https://github.com/jenkinsci/docker).

The base image of this Jenkins image is a Debian image, but there are several layers between the 
Debian and the Jenkins image.
These intermediate layers and also the Jenkins image it self are installing packages that are only
required during the installation and are useless once Jenkins is operating.
Therefore an own Jenkins image should be created that uses less disk space and only contains the
required packages and tools.

### Creating the Dockerfile
The [official Dockerfile](https://github.com/jenkinsci/docker) was modified.
To use less disk space the Jenkins image uses JRE instead of JDK.
Consider to install a specific JRE version instead of the default one.
This could also improve the reproducibility of the created images.
The modified Jenkins image will also inherit directly from Debian base image instead of the
intermediate images.

The created Jenkins image size could be even smaller.
When Docker creates the image with the Jenkins Dockerfile,
some binaries are downloaded with curl.
These resources could be pre downloaded and managed in a binary repository.
In the Dockerfile the binaries could be added to the image with the `COPY` command.
This would lead into extra disk space for the pre downloaded binaries.
Also additional effort for the binary repository management would be required.

The creation of this Dockerfile shows the difficulty to choose between maintainability,
reproducibility, speed and size.

### Do not Install with Package Manager
In the first approach the Docker file used Debian:jessie as base image and added
the Jenkins repository as Debian package source.
Afterwards Jenkins was installed with `apt-get install -y jenkins`.
This approach leads into images that cannot be reproduced at some time.
Whenever a new version between two executions of the Dockerfile is released,
the images are created with different Jenkins versions.

Currently the Dockerfile also installs `default-jre` with `apt-get`,
this should also be changed to a specific java version for reproducible images.

### Minimize Modifications in Dockerfile
The first approach used a completely new Dockerfile and removed everything that was not required.
The advantage of this procedure is that the created image is as small as possible.
But the maintenance of the Dockerfile would be better if the Dockerfile stays as close to the
official implementation as possible.
This simplifies merging the changes to the own file.

##  Using Volume Container for Jenkins Master
Data containers can be used to separate the application from its data.
For a Jenkins server in BiZEPS this makes sense.
If a new Version of Jenkins is installed, a new Jenkins Master image has to be created.
With a data container, the new Jenkins image can be tested with the runtime data from the previous version.
The Jenkins settings, build jobs settings, users and also the installed plugins are stored in the data container.
The Jenkins Master image contains only the Jenkins application.

###	Docker Volumes
When starting a container, the data is usually not persitent.
Everything that is stored in a running container gets lost as soon as the container is removed.
Docker volumes are addressing this issue.
When a Docker container is started, a volume could be mapped.
The `-v /path` option in `docker run` defines, that the volume exists outside of Dockers union file system.
Docker will map the path to a directory on the host.
The exact (container dependent) location on the host machine can be seen with `docker inspect <container>`.
When files are added or modified in the specific host directory,
the changes are also visible in the docker container that mounted this volume.

When writing a Dockerfile, the `VOLLUME` command can be used.
This has the same effect as starting the container with the `-v` option.

###	Docker Data Only Container
Docker allows to define data only containers that can be shared between multiple containers.
A data only container is a Docker container only for data.
The container have to be created from an image but must not be started.
In BiZEPS the docker data only container is created with the command:

`docker create --name dciJenkinsHome dci/voljenkins`

The Jenkins Master container can use this volume with the docker command:

`docker run --name dciJenkins --volumes-from dciJenkinsHome dci/jenkins`

With the correct setup of the `dciJenkinsHome` container,
the Jenkins data is encapsulated in the data container.
This should simplify backup, restore and update strategy as also to share data between containers.

Be aware, if the jenkins data container is deleted, the data is lost!

###	Proper Data Only Container Setup
To benefit from data only containers a proper setup is required.
When a data only container is created, the base image is essential.
To use a small base image to keep the image for the data container small is a bad idea.
The used base image defines the containers file system.


Why should a data container be created from a productive image instead of a small base such as scratch or busybox?

- It will not take more disk space, because of the Docker image layer characteristics 
- The image gets a chance to seed the volume with data such as default files
- The permissions and owners will be correct

See:

- http://docs.docker.com/userguide/dockervolumes/
- http://container-solutions.com/understanding-volumes-docker/
- http://container42.com/2014/11/18/data-only-container-madness/
- http://container42.com/2013/12/16/persistent-volumes-with-docker-container-as-volume-pattern/
- http://container42.com/2014/11/03/docker-indepth-volumes/
- https://medium.com/@ramangupta/why-docker-data-containers-are-good-589b3c6c749e

###	Backup and Restore with Volume Containers

##  Jenkins Docker Plug In

### Disable TLS
Disable TLS verification for docker deamon (test purpose only).
**It is strongly not recommended to disable this socket encryption!**
Doing so is a massive security risk because the socket is accessible from everywhere in the network.
But for testing purpose it may be useful to temporary deactivate the docker port encryption.
This can be done with the entry `DOCKER_TLS=no` in the `/var/lib/boot2docker/profile` file.

After modifying the `profile`, the docker engine has to be restarted.
- Stop all running containers
- In the boot2docker shell type
  - `docker-machine stop default`
  - `docker-machine start default`
  - `default` ist the current docker machines instance name
  - The machine name can be printed with the command `docker-machine active`
  
### Docker Plug In
- https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin
- `Configure System/Cloud`
  - Add new docker cloud
  - Docker URL of local host (http://172.17.42.1:2376)
  - Add new Template
    - Docker Image: `dci/jenkinsslave`
    - Label: `dci-slave`
    - Add Cridentials: `jenkins`, `jenkins`
- Create new job
  - Freestyle project
  - Restrict where this project can run
  - Set label from Docker cloud template `dci-slave`

## Jenkins Docker Slave
Use the Jenkins plug in to manage Jenkins Docker slaves.
The docker plug in starts a Docker container from a specific image and
runs the Jenkins slave in that container.
After the build step, the Docker container is removed again.
The Docker Jenkins slave image requires JRE and an SSH server.

https://registry.hub.docker.com/u/evarga/jenkins-slave/dockerfile/
