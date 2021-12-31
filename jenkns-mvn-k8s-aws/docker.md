# Docker
## Deploy build to docker container
******************************
## Install docker
## create user 'dockeradmin'
```
useradd dockeradmin
passwd ********
```
```
usermod -aG docker dockeradmin
```
## by default ec2 doesn't allow login using password
## Allow login using password
```
vi /etc/ssh/sshd_config
PasswordAuthentication yes
```
### Uncomment it
```
service sshd reload
```
********************************
# Create own tomcat image
## Pull centos from docker Hub
## Install Java
## Create /opt/tomcat directory
## Change work directory to /opt/tomcat
## Downlaod tomcat package
## extract tar.gz file
## Rename to tomcat directory
## Tell to docker that it runs on port 8080
## start tomcat service
## Dockerfile from base CENTOS
```
FROM centos:latest
RUN yum install -y java
RUN mkdir /opt/tomcat
WORKDIR /opt/tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.56/bin/apache-tomcat-9.0.56.tar.gz /opt/tomcat
RUN tar -xzvf apache-tomcat-*.tar.gz
RUN mv apache-tomcat-*/* /opt/tomcat
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
```
## Dockerfile from base TOMCAT
```
FROM tomcat:latest
RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
```
## command to build docker image
```
docker build -t <image-name> -f <dockerfile name- if other than dockerfile> .
docker build -t myimage .
docker build -t myimage -f mydockerfile .
```
********************
