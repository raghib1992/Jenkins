# Nexus

## Install Java
yum install java-1.8.0-openjdk-devel -y

## Install Nexus
https://help.sonatype.com/repomanager3/product-information/download

https://download.sonatype.com/nexus/3/nexus-3.40.1-01-unix.tar.gz

tar -xvf nexus-3.40.1-01-unix.tar.gz

### It will create 2 folder
1. sonatype-work
default admin password and credential and logs file

2. nexus-3.4.1-01 
/bin 
file nexus.rc
```
run_as_user="ec2-user"
```
sh nexus start


nestat -plunt | grep -i :8081
ps -aux | gerp -i java

http://<public ip>:8081
default user = admin
password = cat /opt/sonatype-work/nexus3/admin.password

set new password

************************
# Integrate Nexus with Maven 

Repo- maven snapshot- for build project- code not for production
Repo - maven release- for production


copy the repo url 

add it pom.xml

<distributionManagement>
   <snapshotRepository>
      <id>nexus-snapshots</id>
      <url>http://65.0.74.168:8081/repository/maven-snapshots/</url>
   </snapshotRepository>
   <repository>
      <id>nexus-releases</id>
      <url>http://65.0.74.168:8081/repository/maven-releases</url>
   </repository>
</distributionManagement>


Authentication for Nexus sewrver
vi /apache-maven-****/conf/setting.xml
    <servers>
    <server>
        <id>nexus-snapshots</id>
        <username>admin</username>
        <password>nexus123</password>
    </server>
    <server>
        <id>nexus-releases</id>
        <username>admin</username>
        <password>nexus123</password>
    </server>
    </servers>


Nexus Server Credential 
username admin
password nexus123



