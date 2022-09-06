# Deploy artifact to tomcat server using ssh server
Download plugin ssh agent


*******************************
Add Credential
***************************
# Tomcat on Window Machine
Set-Item WSMan:\localhost\Client\TrustedHosts *
Set-ExecutionPolicy RemoteSigned –Force
install a new plugin named EnvInject Plugin for transferring variables e.g. passwords
************************************************

https://hodgkins.io/automating-with-jenkins-and-powershell-on-windows-part-1
https://hodgkins.io/automating-with-jenkins-and-powershell-on-windows-part-2
https://techexpert.tips/powershell/powershell-copy-files-remote-computers/

Client
Enable-PSRemoting -Force


Domain Server
Test-WSMan <client IP>
Enter-PSSession -ComputerName 172.31.9.223 -Credential <username>

curl -u admin:Jfrog@123 -XGET http://3.110.227.79:8081/artifactory/webapp/#/artifacts/browse/tree/General/nadim-local/sampleWeb-0.0.3-SNAPSHOT.war --output pilot-mdm.war



_____________________________________________________________________

# TOMCAT on Linux Server
/apache-tomcat-8.6.**/bin/
sh startup.sh
____________________________________________________________________

# Tomcat
## download tar.gz file
### link 
##### https://downloads.apache.org/tomcat/tomcat-9/v9.0.56/bin/apache-tomcat-9.0.56.tar.gz.asc
#### https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz
## Install in tomcat server
```
cd /opt
wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz
tar -xzvf apache-tomcat-9.0.56.tar.gz
mv apache-tomcat-9.0.56.tar.gz tomcat
cd /tomcat/bin
./startup.sh
```
## open in borwser from outside the server
### edit
```
/opt/tomcat/webapps/host-manager/META-INF/context.xml
/opt/tomcat/webapps/manager/META-INF/context.xml
```
### Find the line with this item:
```
allow="127.d+.d+.d+|::1|0:0:0:0:0:0:0:1" />
```
### Replace it with the following:
```
allow="127.d+.d+.d+|::1|0:0:0:0:0:0:0:1|.*" />
```
### edit context.xml
### find context.xml file
```
find / -name context.xml
```

#### comment out restriction to open only from inside server
## to set password on manager-app
### edit /tomcat/conf/tomcat-user.xml
```
 <role rolename="manager-gui"/>
 <role rolename="manager-script"/>
 <role rolename="manager-jmx"/>
 <role rolename="manager-status"/>
 <user username="admin" password="admin" roles="manager-gui, manager-script, manager-jmx, manager-status"/>
 <user username="deployer" password="deployer" roles="manager-script"/>
 <user username="tomcat" password="tomcat" roles="manager-gui"/>
```
_____________________________________________________________
# How to change port
go to fileder 

/opt/tomcat/apache-tomcat-8.5.81/conf
vi server.xml
chnage connector port 