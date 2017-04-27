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
                                                                                   | k)Container        | |
                                                                                   |   Jenkins slave    +-+
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
| +------------------------+ +---+----------------+ +---+----------------------------+ +----+---------+-------+ |
| |                        | |                    | |                                | |                      | |
| | d) eth0                | | e) localhost       | | f) Routing table entry         | | g) docker0 bridge    | |
| |    (192.168.0.10)      | |    (127.0.0.1)     | |    (192.168.0.50 => 127.0.0.1) | |    (172.17.0.1)      | |
| |                        | |                    | |                                | |                      | |
| +------------------------+ +--------------------+ +--------------------------------+ +----------------------+ |
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
####  i) Docker daemon REST API access
####  j) Network access

### Jenkins Slave
####  k) Container Jeknins slave
####  l) SSH
####  m) Network access

[next: Docker Configuration](02_DockerConfiguration.md)