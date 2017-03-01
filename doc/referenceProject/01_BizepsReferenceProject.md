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
|                      |                              +--------------------------------+     |        |
|                      |                              |                                |     |        |
| +-----------------+  |                              | h) Container                   +-----+        | m) Network
| |                 |  |                              |    Jenkins master              |  l) SSH      |    access
| | c) Certificates +<--------------------------------+                                |              |
| |    Docker TLS   |  |                              +-+----------------------------+-+              |
| |                 |  |                                |                            ^                |
| +----------+------+  |     +---------------------+    |                            |                |
|            ^         |     |                     |    | i) Docker daemon           |                |
|            +---------------+ a) Docker daemon    |    |    Rest API access         | j) Network     |
|                      |     |                     |    |    (192.168.0.50)          |    access      |
|                      |     +---------------------+    |                            |                |
|                      |     |                     |    |                            |                |
|                      |     | b) Docker rest API  |    |                            |                |
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

### Docker Daemon
####  a) Docker daemon
####  b) Docker rest API
####  c) Certificates Docker TLS

### Network
####  d) eth0
####  e) localhost
####  f) Routing table entry
####  g) docker0 bridge

### Jenkins Master
####  h) Container Jenkins master
####  i) Docker daemon rest API access
####  j) Network access

### Jenkins Slave
####  k) Container Jeknins slave
####  l) SSH
####  m) Network access


