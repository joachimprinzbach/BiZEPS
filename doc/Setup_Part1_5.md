#   Part 1.5: Knowing boot2docker

##  boot2docker on Windows
boot2docker pre configures the Docker deamon and starts it with predefined parameters.
For some use cases these configurations have to be modified.

###  boot2docker Config
The boot2docker configuration can be displayed with `boot2docker config` command.
The default configuration is used as long as no configuration profile is available.
If no profile is available, the configuration can simply be exported with
`boot2docker config > ~/.boot2docker/profile`.
This prints the boot2docker configuration into the **Windows** home directory of the current user.
The configuration file can be modified and the new settings are used as soon as boot2docker is started again.

See [boot2docker-cli](https://github.com/boot2docker/boot2docker-cli) for more information.

### boot2docker Deamon
A Docker deamon is started automatically when boot2docker is started.
The boot2docker image also provides a configuration file to modify the startup behavior of the deamon.

The **VM** directory `/var/lib/boot2docker` is used to configure the Docker deamon.
Add or modify the file named `profile` to modify the deamons behavior.
The variable `EXTRA_ARGS` allows to modify the deamons options flag.
For example `EXTRA_ARGS="--default-ulimit core=-1` can be added.
But afterwards the deamon has to be restarted with `boot2docker restart`.

See [boot2docker](https://github.com/boot2docker/boot2docker) for more information.

### Docker Deamon Remote API
The Docker deamon exposes a REST API to its functionalities on the Docker socket.
When using boot2docker the Deamons socket is exposed *encrypted* by default at port `2375`.
3rd parity applications may use this API to execute commands such as starting or stopping containers.
By default this interface is secured by boot2docker.
It automatically generates certificates during the installation and stores them in `/home/docker/.docker`.
The certificates are also stored in the Windows user home directory at `.boot2docker/certs/boot2docker-vm`.

**It is strongly not recommended to disable this socket encryption!**
Doing so is a massive security risk because the socket is accessible from everywhere in the network.
But for testing purpose it may be useful to temporary deactivate the docker port encryption.
This can be done with the entry `DOCKER_TLS=no` in the `/var/lib/boot2docker/profile` file.

Other sockets that should be exposed as Docker sockets can also be configured with the profile.
Adding the entry `EXTRA_ARGS="-H tcp://0.0.0.0:4243` exposes the Docker socket
on the whole network on port 4232.
Use this feature carefully and use the provided certificate encryption whenever possible.
See [Protect Docker Deamon Socket](https://docs.docker.com/articles/https/) for more information.
