# ansible
## create user ansadmin
```
useradd ansadmin -m
passwd ansadmin
```
## provide sudo rights with passwword
```
add it on visudo file
```
## enable ssh access with password
```
edit /etc/ssf/sshd_config
PasswordAuthentication yes
```
## Install docker
```
sudo yum install docker -y
```
## add ansadmin user to docker group 
```
usermod -aG docker ansadmin
```
## Create dockerfile
```
FROM tomcat:latest
RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
COPY ./*.war /usr/local/tomcat/webapps
```
## Create docker images from dockerfile
```
docker build -t regapp:latest .
```
## push the image to docker hub repository
```
docker login
docker tag <tag> <dockerhub username>/regapp:latest
docker push <dockerhub username>/regapp:latest
```

