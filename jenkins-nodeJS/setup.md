# Jenkins 
## Download plugin NodeJS Plugin
## Install Nodejs - Global Tool Configuration

Job - build nodejs app
Git - pull source code
Node - use nodejs tool
build npm install

# Jon - build node js with docker
plugin Cloudbees docker build and publish plugin
## Dockerfile
```
FROM jenkins/jenkins:lts
USER root

RUN mkdir -p /tmp/download && \
 curl -L https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz | tar -xz -C /tmp/download && \
 rm -rf /tmp/download/docker/dockerd && \
 mv /tmp/download/docker/docker* /usr/local/bin/ && \
 rm -rf /tmp/download && \
 groupadd -g 999 docker && \
 usermod -aG staff,docker jenkins

USER jenkins
```
## Build Docker image for above dockerfile
```
docker build -t <image-name> .
```

