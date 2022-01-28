# Jfrog
## Install Artifactiory on different server than jenkins
## Check linux Os and its version
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