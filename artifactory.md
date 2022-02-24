# Jfrog

Ref to Download 
zip
https://releases.jfrog.io/artifactory/bintray-artifactory/org/artifactory/oss/jfrog-artifactory-oss/
tar
https://jfrog.com/community/download-artifactory-oss/

Ref to Install
https://www.jfrog.com/confluence/display/JFROG/Installing+Artifactory

## Install Artifactiory on different server than jenkins
## Pre-requisites:
### 1. An AWS T2.small EC2 instance (Linux)
### 2. Open port 8081 and 8082 in the security group
### Login to instance as a root user and install Java
```
yum install java-1.8* -y 
```
### Download Artifactory packages onto /opt/
#### For Latest version of Artifactory OSS

Ref https://www.jfrog.com/confluence/display/RTF6X/Installing+on+Linux+Solaris+or+Mac+OS
```
cd /opt 
wget https://jfrog.bintray.com/artifactory/jfrog-artifactory-oss-6.9.6.zip
```
### extract artifactory tar.gz file
```
unzip jfrog-artifactory-oss-6.9.6.zip
```
## Go inside to bin directory and start the services
```
cd /opt/jfrog-artifactory-oss-6.9.6/bin
./artifactory.sh start
```
## access artifactory from browser
```
http://<PUBLIC_IP_Address>:8081 
```
## Provide credentials
```
username: admin
password: passwrod 
```
### Create user for Jenkins
Security -> users
************************************************************
# Install Artifactory on Docker
## ref https://jfrog.com/community/download-artifactory-oss/
```
docker pull releases-docker.jfrog.io/jfrog/artifactory-oss:latest
docker run -d -p 8081:8081 release-docker.jfrog.io/jfrog/artifoctory-oss:latest
```
## Check linux OS and its version
```
cat /proc/version
```
************************************************************
# Install artifactiry on amazon-linux-machine-2
## Install Java
```
amazon-linux-extras list
amazon-linux-extras install java...
```
## find java home dir
```
update-alternatives --display java
```
## get the path
```
vi ~/.bash_profile
export JAVA_HOME=<above path>
PATH=$JAVA_HOME/bin
```
```
source .bash_profile
```
## Install Artifactory
### REF https://www.jfrog.com/confluence/display/RTF6X/Installing+on+Linux+Solaris+or+Mac+OS
```
wget https://bintray.com/jfrog/artifactory-rpms/rpm -O bintray-jfrog-artifactory-rpms.repo
sudo mv bintray-jfrog-artifactory-rpms.repo /etc/yum.repos.d/
sudo yum install jfrog-artifactory-oss

service artifactory start
```
************************************************************
# Install jfrog on ubuntu
## Prerequisites
### Install Java JDK
```
apt-get update -y
sudo apt-get install openjdk-8-jdk -y
```
### set Java Home path
### Install jfrog artifactory
### Ref 
### for ubuntu 18.04
#### Ref: https://websiteforstudents.com/how-to-install-jfrog-artifactory-on-ubuntu-18-04-16-04/
```
apt install wget software-properties-common
wget -qO - https://api.bintray.com/orgs/jfrog/keys/gpg/public.key | apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://jfrog.bintray.com/artifactory-debs $(lsb_release -cs) main"
sudo apt update
sudo apt install jfrog-artifactory-oss
systemctl start artifactory.service
systemctl enable artifactory.service
```
### open artifactory in web browser
```
www.localhost:8081/artifactory
```
## install tomcat-webapps tomcat-admin-webapps
### super user set
```
vi /opt/jfrog/artifactory/app/artifactory/tomcat/conf
```
***********************************************
# On Jenkins Side
## Install plugin
```
Artifactory Plugins
```
## Configure System
### Artifactory
```
add
ServerID    server-hostname/ip
url         http://server-hostname:8081/
username    admin
password    password
```
***********************************************