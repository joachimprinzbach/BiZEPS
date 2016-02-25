[home](01_BiZEPS_Introduction.md)

#   The Concept of BiZEPS
- Everything is a docker container
- The image repository is a collection of supported tool chains
- Build jobs
  - Are executed in a (Jenkins) slave container
  - The container is destroyed after the build job
- No installations on the server it self
  - Only the docker deamon
  - Keep server clean
- Outdated Tools
  - Remove the container
  - Easier than uninstalling a tool from the server (with dependencies)

##  BiZEPS Images
A repository of tools and chains, ready to use

- Base Image Debian:Jessie
  - Jenkins Master with JRE, Jenkins and Git
  - Jenkins Slave with JRE, Python, SSH Server
    - Doxygen Slave
    - GCC 4.8 Slave
    - GCC 4.9 Slave
      - Google test
      - CPP unit
      - Boost unit tests
  - TeamCity Master
  - TeamCity Slave
  - ...

##  BiZEPS Container Architecture
```
Containers
                  +---SSH----------+-------------+
                  |                |             |
                  |                v             v
            +-----+------+    +----+---+    +----+----+
            | Jenkins    |    | GCC    |    | Doxygen |
            | Container  |    | Slave  |    | Slave   |
            |            |    |        |    |         |
            +------*-----+    +--------+    +---------+
                   *
                   ***HTTP************
                                     *
+---------------+--------------------*----------------+
|               |                    *                |
| Docker deamon | Virtual Network    *                |
|               |                    *                |
+---------------+--------------------*----------------+
|                                    *                |
| Docker Host                        *                |
|                                    *                |
+------------------------------------*----------------+
                                     *
                                     X
```

#  What's Next?
[Interesting use cases](05_BiZEPSUseCases.md)
