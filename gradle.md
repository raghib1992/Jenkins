*********************************
# ***** Gradle ********
*********************************
# Install Gradle through Jenkins-Global Tool Configuration

********************************
# Install Gradle manually on ubuntu and configure to jenkins
## Ref https://gradle.org/install/
## Prerequisites
### Install JDK
### Ref https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-20-04#installing-specific-versions-of-openjdk
```
sudo apt update
sudo apt install default-jre
java -version
sudo apt install default-jdk
javac -version
```
### Install Gradle
```
wget https://gradle.org/next-steps/?version=7.3.3&format=bin
mkdir /opt/gradle
unzip -d /opt/gradle gradle-7.3.3-bin.zip
ls /opt/gradle/gradle-7.3.3
export PATH=$PATH:/opt/gradle/gradle-7.3.3/bin
```
*********************************
# Gradle Script
