[home](01_BiZEPS_Introduction.md)

#  What Is a Build Server?
## A Common Build Server

```

+----------------+   +------------------------+       +------------------------+     +----------------+
|                |   |                        |       |                        |     |                |
|  Source Repo   |   | STL Library X86        +<------+  GCC Toolchain         +---->+ Boost Library  |
|                |   |                        |       |                        |     |                |
+----------------+   +------------------------+       +------------------------+     +------+---------+
                                                                                            ^
                     +------------------------+       +------------------------+            |
                     |                        |       |                        |            |
                     | STL Library Target     +<------+ Cross Target Toolchain +------------+
                     |                        |       |                        |
                     +------------------------+       +------------------------+

                     +-----------+  +-------------+  +-----------+  +-----------+ +----------+
                     |           |  |             |  |           |  |           | |          |
                     |  Doxygen  |  | Some Tools  |  | Old Stuff |  | JAVA      | | Jenkins  |
                     |           |  |             |  |           |  |           | |          |
                     +-----------+  +-------------+  +-----------+  +-----------+ +----------+

 +-------------------------------------------------------------------------------------------+
 |                                                                                           |
 |                     Ubuntu 14.04 LTS                                                      |
 |                                                                                           |
 +-------------------------------------------------------------------------------------------+

```

## What's Wrong With This?
- Build server grows over time
  - Things are added and updated
  - Obsolete tools are seldom removed
- What versions are installed?
  - JAVA, jdk or jre? What version?
  - Jenkins and its plugins?
  - Doxygen?
  - Dependencies of the packages?
- Multiple tool chains and libraries
  - In different versions
  - For different targets
  - Reproduce a build from 2 years ago?
  - Add a new target
- How to test a new version of a tool?
- Is there a risk to upgrade the OS?

> **These issues may be resolved by**
  - Documentation
  - Additional HW
  - Virtualization
  - ...

#  What's Next?
[What is docker?](03_Docker.md)
