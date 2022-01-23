******************************
# ****** Maven ************
******************************
## Install maven in jenkins server
### Download binary
#### search for download maven
```
https://dlcdn.apache.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz
```
#### Install maven
```
cd /opt
wget https://dlcdn.apache.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz
tar -xzvf apache-maven-3.8.4-bin.tar.gz
mv apache-maven-3.8.4-bin maven
```
## Setup environment variable - JAVA_HOME, M2, M2_HOME
### set bash_profile of root user
```
cd ~
ls -la
vi .bash_profile
```
### get the java location
```
find / -name jvm
or
alternatives --config java
```
### edit .bash_profile
```
M2_HOME=/opt/maven
M2=/opy/maven/bin
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.13.0.8-1.amzn2.0.3.x86_64
PATH=:$M2:$M2_HOME:$JAVA_HOME
```
### to update path
```
source .bash_profile
```
## Install maven plugins
### install plugin 'Maven Integration'
## Configure maven and java
### configure into "Global Tool Configuration"
#### maven - name and path
#### jdk - name and path