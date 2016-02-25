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
- Public and private repositories

```
                        +----------------+
                        v                |
Dockerfile ----> Docker image ----> Repository---------> other machine ----> container



```

#  What's Next?
[What is docker?](04_BiZEPSConcept.md)
