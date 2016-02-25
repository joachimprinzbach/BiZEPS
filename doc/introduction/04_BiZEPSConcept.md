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
```

Tool image      Jenkins image

Base image

Deamon

Host

```
##  BiZEPS Container Architecture


#  What's Next?
[What is docker?](05_BiZEPSUseCases.md)
