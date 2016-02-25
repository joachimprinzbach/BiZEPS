[home](01_BiZEPS_Introduction.md)

#   What Is Docker?
- Provides an environment to build, run and distribute containers
- Containers are lightweight virtual machines

```
+---------------+  +---------------+  +---------------+
|               |  |               |  |               |
| Container A   |  | Container B   |  | Container X   |
| GCC           |  | Doxygen       |  | ...           |
|               |  |               |  |               |
+---------------+  +---------------+  +---------------+
+-----------------------------------------------------+
|                                                     |
| Docker deamon                                       |
|                                                     |
+-----------------------------------------------------+
+-----------------------------------------------------+
|                                                     |
| HOST (Ubuntu 14.04)                                 |
|                                                     |
+-----------------------------------------------------+
```

##  Container and Images
- A container is an instance of an image
- An image contains the 'installed tools'
- Images may be layered
- An image can be described in a doxyfile (installation script)

```
+---------------+  +---------------+  +---------------+
| Image A       |  | Image B       |  | Image C       |
| GCC           |  | Doxygen       |  | Jenkins       |
+---------------+--+---------------+--+---------------+
| JRE, Python, Git                                    |
+-----------------------------------------------------+
| Debian:Jessie                                       |
+-----------------------------------------------------+
```

##  Combining Containers
- Containers can interact with each other
  - Through file system mapping
  - Virtual network (TCP/IP ...)
- Containers can interact with the host network interface

##  Distributing Images
- The docker environment provides a repository
- Distribute pre built imaages
- Each image has a revision
- Public and private repositories

```
+------------\    +-----------\
|             \   |            \
| Dockerfile  |   | Dockerfile |
| Jenkins     |   | GCC        |
|             |   |            |
+-----+-------+   +-----+------+
      |                 |
      v                 v
+----------------------------+             +---------------------------+
|                            |             |                           |
|  Docker Image Repository   |             | Server    +------------+  |
|                            |             |           | Container  |  |
|  +-------------------+     |             |           | GCC        |  |
|  |                   |     |             |           |            |  |
|  | Image GCC V1      |     |             |           +------------+  |
|  |                   |-+   |             |                           |
|  +-+-----------------+ |   |             | +-----------+             |
|    | Image GCC V2      |   |             | |           |             |
|    |                   |   |             | | Container |             |
|    +-------------------+   |             | | Jenkins   |             |
|                            +------+      | |           |             |
|                            |      |      | +-----------+             |
|                            |      |      |                           |
|                            |      |      +---------------------------+
|                            |      |      |                           |
|                            |      |      | +------------+ +--------+ |
|  +-------------------+     |      |      | |            | |        | |
|  |                   |     |      |      | | Image      | | Image  | |
|  | Image Jenkins V1  |     |      +----->+ | Jenkins V1 | | GCC V2 | |
|  |                   |     |             | |            | |        | |
|  +-------------------+     |             | +------------+ +--------+ |
|                            |             | Local Image Repo          |
|                            |             |                           |
+----------------------------+             +---------------------------+
```

#  What's Next?
[The concept of BiZEPS](04_BiZEPSConcept.md)
