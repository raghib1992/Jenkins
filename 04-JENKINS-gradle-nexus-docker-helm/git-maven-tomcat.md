# Install jenkins

## Tomcat and jenkins both work on port 8080;
### change the port of the Jenkins
```
vi /etc/sysconfig/jenkins
JENKINS_PORT="8081"
```

## IN JENKINS

### Plugins

### Global tool configuration
#### JDK
#### add JAVA_HOME as per "/etc/systemd/system/tomcat.service"


# Install Tomcat
- REF: *https://techviewleo.com/install-tomcat-on-amazon-linux/*
## Create user tomacat
```sh
# Add group tomacat
sudo groupadd tomcat
# Add User tomcat
useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
```
## Downaload and install Tomacat
### Link
```
https://downloads.apache.org/tomcat/tomcat-9/v9.0.56/bin/
```
### downolad
```
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.56/bin/apache-tomcat-9.0.56.tar.gz
```
### unzip and copy into /opt/tomcat
```
sudo tar -xzvf apache-tomcat-9.0.56.tar.gz -C /opt/tomcat --strip-components=1
```
### install
```
sudo chgrp -R tomcat /opt/tomcat
cd /opt/tomcat
chmod -R g+r conf
chown -R tomcat webapps/ work/ logs/ temp/
```
### configure tomcat
#### check java_home
```sh
alternatives --config java
# output (/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.312.b07-1.amzn2.0.2.x86_64/jre/bin/java)
```
#### tomcat service conf
#### edit /etc/systemd/system/tomcat.service
##### Note modify JAVA_HOME as per above path obtain in below file
```
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.292.b10-1.el7_9.x86_64/jre
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always
```
#### edit /opt/tomcat/conf/tomcat-user.xml
```
<user username="testadmin" password="deployer" roles="manager-script"/>
```
#### commant it /opt/tomcat/webapps/manager/META-INF/context.xml
```
<!--
  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
-->
```
## start tomcat server
```
systemctl start tomcat
systemctl enable tomcat
systemctl status tomcat
```