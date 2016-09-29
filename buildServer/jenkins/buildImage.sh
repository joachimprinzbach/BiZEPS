#!/bin/sh

# Builds the required images required for BiZEPS from the Dockerfiles
# -t defines the name for the created images

docker build -t biz/jenkinsuser ./user
resultJenkinsUser=$?
docker build -t biz/jenkins ./master
resultJenkinsMaster=$?
docker build -t biz/jenkinsslave ./slave
resultJenkinsSlave=$?
docker build -t biz/jenkinscerts ./masterCerts
resultJenkinsCerts=$?

echo "--------------------------------"
resultsSum=$((resultJenkinsUser + resultJenkinsMaster + resultJenkinsSlave + resultJenkinsCerts))
if [ "$resultsSum" -gt "0" ] 
then
  echo "WARNING: Not all images successfully created!!!"
  echo "JenkinsUser=$resultJenkinsUser"
  echo "JenkinsMaster=$resultJenkinsMaster"
  echo "JenkinsSlave=$resultJenkinsSlave"
  echo "JenkinsCerts=$resultJenkinsCerts"
else
  echo "All images successfully created."
fi
exit $resultsSum
