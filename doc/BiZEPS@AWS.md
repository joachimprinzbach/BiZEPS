#	Using BiZEPS with Amazon Cloud
How to setup BiZEPS on AWS.

##	Setup
###	Selecting Image
- Used Image from Amazon Market Place:
[Amazon ECS-Optimized Amazon Linux AMI](https://aws.amazon.com/marketplace/pp/B00U6QTYI2/ref=sp_mpg_product_title?ie=UTF8&sr=0-2)
- Modify Security Settings
	- Open Port 22 for SSH (Putty) for current Address only
	- Open Port 8080 for Webserver access
- Connect with Putty, private key
  - User: ec2-user

###	Install and Startup Docker
- Install
	- `sudo yum update -y`
	- `sudo yum install -y docker`
	- Version 1.7.1 was already installed
- `sudo service docker start`
- Add ec2-user to use the service without sudo
	- `sudo usermod -a -G docker ec2-user`
- Logout and log in to pick new docker group permissions
- Configure docker
	- modify `/etc/sysconfig/docker`
	- added `-H unix:///var/run/docker.sock -H tcp://0.0.0.0:2375`

###	Access Private Git Repo from AWS
- Install Git
	- `sudo yum install -y git`
- Create new SSH keys to access private git repo from AWS cloud
- Add the **private** key to the aws ssh client
	- `ssh-add ~/.ssh/id_rsa`
- Add the **public** key to the git repo
	- `cat ~/.ssh/id_rsa.pub`

###	Setup BiZEPS
- Clone the BiZEPS repo
- execute buildBiZEPS.sh

### Configure BiZEPS
- Temporary set the Amazon BiZEPS Security settings,
  to allow only my IP at Port 80 and 8080
- execute jenkinsStart.sh
- Starting BiZEPS on AWS micro instance takes much longer than expected!
- Working with Jenkins on micro instance is very slow...

###	Issue
It seems as if the SSH client of the docker slave cannot be started or connected

 

 