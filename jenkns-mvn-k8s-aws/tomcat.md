# Tomcat
## download tar.gz file
### link https://downloads.apache.org/tomcat/tomcat-9/v9.0.56/bin/apache-tomcat-9.0.56.tar.gz.asc
## Install in tomcat server
```
cd /opt
wger https://downloads.apache.org/tomcat/tomcat-9/v9.0.56/bin/apache-tomcat-9.0.56.tar.gz.asc
tar -xzvf apache-tomcat-9.0.56.tar.gz
mv apache-tomcat-9.0.56.tar.gz tomcat
cd /tomcat/bin
./startup.sh
```
## open in borwser from outside the server
### edit context.xml
### find context.xml file
```
find / -name context.xml
```
### edit
```
/opt/tomcat/webapps/host-manager/META-INF/context.xml
/opt/tomcat/webapps/manager/META-INF/context.xml
```
#### comment out restriction to open only from inside serfver
## to set password on manager-app
### edit /tomcat/conf/tomcat-user.xml
```
 <role rolename="manager-gui"/>
 <role rolename="manager-script"/>
 <role rolename="manager-jmx"/>
 <role rolename="manager-status"/>
 <user username="admin" password="admin" roles="manager-gui, manager-script, manager-jmx, manager-status"/>
 <user username="deployer" password="deployer" roles="manager-script"/>
 <user username="tomcat" password="s3cret" roles="manager-gui"/>
```