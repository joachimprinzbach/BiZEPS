[prev: BiZEPS Reference Project Overview](01_BizepsReferenceProject.md) | [next: Jenkins Configuration](03_JenkinsConfiguration.md)

#   Docker Configuration
##  Docker Daemon Startup
The BiZEPS reference project starts the daemon with the following parameters:

`dockerd -D --tlsverify --tlscacert=/var/docker/ca.pem --tlscert=/var/docker/server/cert.pem --tlskey=/var/docker/server/key.pem -H tcp://127.0.0.1:2376`

| Parameter   | Description |
| ---         | ---         |
| -D          | Enable debug mode |
| --tlsverify | Use TLS and verify the remote  |
| --tlscacert | Trust certs signed only by this CA (default: ~/.docker/ca.pem) |
| --tlscert   | Path to the TLS certificate (default: ~/.docker/cert.pem) |
| --tlskey    | Path to the TLS server key  (default: ~/.docker/key.pem)  |
| -H tcp://127.0.0.1:2376 | Binds the docker REST API to the specific IP |

### Details

####  Protect the REST API
The reference project protects the REST API with two approaches:

**TLS authentication (certificates):**
Clients have to authenticate themself with a TLS certificate before they can 
interact with the docker daemon through the docker REST API.

**Do not publish in the network:**
The reference project does not provide the docker REST API on a physical network interface.
It is not possible to connect to the docker REST API from the network.
On the one hand this is a limitation but also improves the security.

[prev: BiZEPS Reference Project Overview](01_BizepsReferenceProject.md) | [next: Jenkins Configuration](03_JenkinsConfiguration.md)