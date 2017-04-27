[next: Docker Configuration](02_DockerConfiguration.md)

#   BiZEPS Reference Project

The reference project describes the BiZEPS architecture, setup and configuration by an example.

##  Overview

```

                                                                                       +--------------------+
                                                                                       |                    |
                                                                                     +-+------------------+ |
                                                                                     |                    | |
                                                                                   +-+------------------+ | |
                                                                                   |                    | +-+
                                                                                   | k) Container       | |
                                                                                   |    Jenkins slave   +-+
+----------------------+                                                           |                    |
|                      |                                                           +---------+--------+-+
| Host file system     |                                                                     ^        ^
|                      |                                                                     |        |
| +-----------------+  |                              +--------------------------------+     |        |
| | c) Certificates |  |                              |                                |     |        |
| +    Docker TLS   |  |                              | h) Container                   +-----+        | m) Network
| +=================+  |                              |    Jenkins master              |  l) SSH      |    access
| | client/ca.pem   |<--------------------------------+                                |              |
| | client/cert.pem |  |                              +-+----------------------------+-+              |
| | client/key.pem  |  |                                |                            ^                |
| +-----------------+  |     +---------------------+    |                            |                |
| | server/ca.pem   |  |     |                     |    | i) Docker daemon           |                |
| | server/cert.pem |<-------+ a) Docker daemon    |    |    REST API access         | j) Network     |
| | server/key.pem  |  |     |                     |    |    (192.168.0.50)          |    access      |
| +-----------------+  |     +---------------------+    |                            |                |
|                      |     |                     |    |                            |                |
|                      |     | b) Docker REST API  |    |                            |                |
|                      |     |    (127.0.0.1)      |    |                            |                |
|                      |     |                     |    |                            +------+         |
|                      |     +---+-----------------+    |                                   |         |
|                      |         ^                      |                                   |         |
+----------------------+         |                      |                                   |         |
+---------------------------------------------------------------------------------------------------------------+
|                                |                      |                                   |         |         |
| Host network setup             |                      |                                   |         |         |
|                                |                      v                                   v         v         |
| +------------------------+ +---+------------+     +---+----------------------------+ +----+---------+-------+ |
| |                        | |                |     |                                | |                      | |
| | d) eth0                | | e) localhost   |<----| f) Routing table entry         | | g) docker0 bridge    | |
| |    (192.168.0.10)      | |    (127.0.0.1) |     |    (192.168.0.50 => 127.0.0.1) | |    (172.17.0.1)      | |
| |                        | |                |     |                                | |                      | |
| +------------------------+ +----------------+     +--------------------------------+ +----------------------+ |
|                                                                                                               |
+---------------------------------------------------------------------------------------------------------------+

```

##  Details
The described architecture is a possible solution, how a BiZEPS project could look like.
This setup is a good starting point which addresses flexibility, scalability and basic security needs.
Other project requirements or customer needs may leed into a different project setup.

### Docker
####  a) Docker daemon
Docker images and container are managed through the docker daemon.
Every docker command (e.g. `docker run ...`) is handled by the docker daemon.

####  b) Docker REST API
The docker daemon provides a REST API to access the daemon and execute docker commands.
The REST API is usually used by applications for interacting with the daemon.
The reference project publishes the docker REST API only on local host.
Remote clients cannot access the docker daemon.

####  c) Certificates Docker TLS
The BiZEPS reference project uses the built in TLS authentication to protect the docker REST API.
A client has to authenticate himself before he can interact with the REST API.
The certificates can be stored on the host, the docker daemon needs access to the server certificates.
With the client certificates the Jenkins master can authenticate himself to the docker daemon.

The BiZEPS projects provides a utility to create self signed server and client certificates (´utils/certGenerator´).

### Network
####  d) eth0
The physical network interface of the host.

####  e) localhost
The reference project publishes the docker REST API (b) only on the local host.

####  f) Routing table entry
A local routing table entry is used to enable the docker
REST API access for other applications on the local host.
A docker container (e.g. Jenkins master (h)) has the possibility to execute docker commands,
but the client has still to authenticate himself with a TLS certificate.

####  g) docker0 bridge
The virtual docker0 interface is created by the docker daemon.
This interface is used by the clients to communicate
- with each other
- with the host
- with other resources in the network (or internet)

### Jenkins Master
####  h) Container Jenkins master
The container with the Jenkins service.
The Jenkins master manages the Jenkins configuration, plugins and builds.
By default Jenkins master creates and starts a slave container for every build job.
The build is executed in a slave container, the build results are returned
to the Jenkins master and afterwards the container is destroyed.

####  i) Docker daemon REST API access
To create, start and destroy containers the Jenkins master
has to interact with the docker daemon (via REST API).
The Jenkins master has to authenticate with the TLS certificate and key to access the docker daemon API.
Jenkins master uses the routing table entry to access the docker daemon.

####  j) Network access
To interact with the Jenkins server the 'public' network interface is published in the network.

### Jenkins Slaves
####  k) Container Jeknins slave
For every build job a dedicated slave container is started.
The slave container contains the utilities to be accessed by the Jenkins master
and the toolchain to fulfill a specific build job.
By default a container shall contain one toolchain (in one specific version).

####  l) SSH
Jenkins master controls the slave containers with an SSH connection.

####  m) Network access
Even Jenkins slave container may access the public network.

[next: Docker Configuration](02_DockerConfiguration.md)