# Release Notes
**V1.0.0, 12.06.2016**

- First release of BiZEPS
- Features
  - Allows to start a Jenkins server in a docker container
  - Jenkins slave without any toolchain installed
  - Raspberry pi Jenkins slave to cross compile for the Raspberry pi
- Tested with Docker V 1.11.0 and 1.11.1

##  Main Components

| Component       | Version | Comment |
|-----------------|---------|---------|
| BiZEPS          | V1.0.0  | |
| Jenkins Master  | V1.658  | |
| Jenkins Slave   | V1.0.0  | |

##  Supported Slaves

| Slave                       | Version   | Comment |
|-----------------------------|-----------|---------|
| Rasperry Pi Cross Compiler  | GCC 4.8.3 | Pre compiled cross compiler from 'git://github.com/raspberrypi/tools.git' |
