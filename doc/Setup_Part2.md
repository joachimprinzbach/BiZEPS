#   Part 2: Create Jenkins Image
For best practices about Dockerfiles see:

- https://docs.docker.com/articles/dockerfile_best-practices
- http://jonathan.bergknoff.com/journal/building-good-docker-images

##  Use Debian as Base Image
In the BiZEBS environment requires multiple docker images to create containers from.
Some of these containers will interact with each other and some have almost no associations
to other containers.
BiZEBS should reuse the same base image (distribution) for as much images as possible.
The reasons are:

- Dockers union file system and layering approach will lead in less disk usage
- Because of Dockers caching capability the creation of derived images is faster
  than to create completely new images
- Using the same base distribution simplifies the maintenance of the containers and images

Debian distribution was chosen as base image because it is mentioned as good base image in the Docker documentation.

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
This could also improve reproducable image createion.
The modified Jenkins image will also inherit directly from Debian base image instead of the
intermediate images.

The created image size could even smaller if the binaries would not be downloaded in the Dockerfile
but pre downloaded and added to the image with the `COPY` command.
But this would lead into extra disk space for the pre downloaded binaries.

The creation of this Dockerfile shows the difficulty to choose between maintainability,
reproducibility, speed and size.

### Do not Install with Package Manager
In the first approach the Docker file used Debian:jessie as base image and added the Jenkins repository
as Debian package source.
Afterwards Jenkins was installed with `apt-get install -y jenkins`.
This approach leads into images that cannot be reproduced at some time.
Whenever a new version between two executions of the Dockerfile is released,
the images are created with different Jenkins versions.

In the first draft of the Dockerfile it also installed `default-jre` with `apt-get`,
this should also be changed to a specific java version.

### Minimize Modifications in Dockerfile
The first approach used a completely new Dockerfile and removed everything that was not required.
The advantage of this procedure is that the created image is as small as possible.
But the maintenance of the Dockerfile would be better if the Dockerfile stays as close to the
official implementation as possible.
This simplifies merging the changes to the own file.

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

##  Jenkins Docker Plug In

## Jenkins Docker Slave

Use the Jenkins plug in to manage Jenkins Docker slaves.
The docker plug in starts a Docker container from a specific image and
runs the Jenkins slave in that container.
After the build step, the Docker container is removed again.
The Docker Jenkins slave image requires JRE and an SSH server.

https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin

https://registry.hub.docker.com/u/evarga/jenkins-slave/dockerfile/
