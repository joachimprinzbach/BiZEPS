# Part 1: Getting Started
On this page:

- [Setup a Docker Host Machine](#p1_setupHost)
- [Docker on Windows](#p1_windows)

#   Setup a Docker Host Machine <a name="p1_setupHost"/>
To start with DockerCI first a host with a working Docker installation is required.
Currently Docker runs only on a Linux distribution and
cannot be installed on Windows.
But Docker can run within a VM with Linux on Windows.
This is where boot2docker is used.

#   boot2docker on Windows <a name="p1_windows"/>
- [boot2docker](https://github.com/boot2docker)
- [Installation on Windows](https://docs.docker.com/installation/windows/)

##  Installer
Docker provides a Windows installer which installs the
required tools and files to use Docker on a Windows machine.
boot2docker-installer prepares a virtual machine for VirtualBox to run a Linux image with Docker installed.
It also installs some dependencies to use the Docker deamon within the VM.
When the installation is finished boot2docker start can be called to run the VM with docker installed.
The Linux image that comes with boot2docker is a light weight distribution with the only purpose:
Run the Docker deamon and Docker containers.

##  VirtualBox and Hyper-V
If the VM does not start correctly it could be that Hyper-V is active on the Windows machine.
On Windows 8.1, Hyper-V is installed and executed by default.
VirtualBox and Hyper-V can not run on the same system.
The easiest way to solve this problem is to deactivate Hyper-V.

Because boot2docker only prepares VirtualBox to run the Linux VM it should also be possible
to run the boot2docker VM with Hyper-V.
This is an interesting approach to check at some time.

- http://blogs.msdn.com/b/scicoria/archive/2014/10/09/getting-docker-running-on-hyper-v-8-1-2012-r2.aspx
- http://blog.thestateofme.com/2014/02/18/boot2docker-on-hyper-v/

##  boot2docker Command Line
boot2docker starts a shell on the Windows client where the user can interact with the VM.
The user can execute docker commands such as `docker run --rm -ti debian`.
The installer also installed the *tool* `boot2docker` which is accessible from the shell
(and if added to the PATH also from Windows command line).
The tool boot2docker can be used to execute some maintenance tasks.
Most of them control the VM.

The bash provided from boot2docker (to be honest, it reuses the git bash) has its own charm and behavior.
There are some problems with paths that are executed into the shell,
because they are potentially reinterpreted by git part.
For example the execution of `docker run ubuntu:15.04 /bin/echo 'hello world'` failed because
the bash redirected the path to `/bin/echo` in the git installation folder.
A leading double slash resolves the issue `//bin/echo`.
But even better is it to use Putty to access the Docker VM.

##  boot2docker and Putty
The setup and integration of the VM into the Windows system is commendable.
The VM and Docker deamon are accessible through the network interfaces.
boot2docker prepared private and public key to connect with SSH to the VM.
Also the Docker deamon API port is secured with certificates by default (more on this later).
To access the VM with Putty the Docker key (located at `%USERPROFILE%\.ssh\id_boot2docker`)
has to be opened with `puttygen.exe` and stored as putty private key.
With this key, Putty is able to connect to the Docker VM over SSH with `docker@127.0.0.1:2022`.

##  Sharing Data with the VM
boot2docker mapped the user directory into the VM.
At `/c/Users/%USERPROFILE%` in the VM the user finds its Windows home directory.
Keep in mind to change the line ending format from Windows to Unix style when transferring shell scripts.

##  Playing Around with Docker
Now with Docker running and Putty SSH access its time to get familiar with docker.
It makes sense to check out the "Hello World" examples and learn how to work with images and containers.
Without any Docker experience it will be difficult to design and setup DockerCI.
