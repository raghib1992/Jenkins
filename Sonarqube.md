# Setup Sonarqube server
## Ref
```
https://devopscube.com/setup-and-configure-sonarqube-on-linux/
https://docs.sonarqube.org/latest/requirements/requirements/
```
## pre-requisites

- Server with minimum 2GB/1 vcpu capacity
- PostgreSQL version 9.3 or greater.
- OpenJDK 11 or JRE 11
- All sonarquber process should run as a non-root sonar user
- Server firewall opened for, sonar will run on 9000

### ubuntu
```
apt install openjdk-11-jre-headless -y
apt install openjdk-11-jdk-headless -y
```

## Downlaod sonarqube
### Ref:
```
https://www.sonarqube.org/downloads/
https://www.sonarqube.org/success-download-community-edition/
https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.5.0.56709.zip
``` 

## Step to install and setup SOnarqube on RHEL/Amazon-Linux/Centos
1. Update the server.
```
sudo yum update -y
```
2. Install wget & unzip
```
sudo yum install wget unzip -y
```
3. Install java 11
```
sudo yum install java-11-openjdk-devel -y
```
4. Login as root and execute the following commands.
```
sysctl vm.max_map_count
sysctl fs.file-max
ulimit -n
ulimit -u
```
### Setup PostgreSQL 10 Database For SonarQube
### or Ref https://www.how2shout.com/linux/install-postgresql-13-on-aws-ec2-amazon-linux-2/
1. Install PostgreSQL 10 repo.
```
sudo yum install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm -y
```
2. Install PostgreSQL 10
```
sudo yum install postgresql10-server postgresql10-contrib -y
```
3. Initialize the database.
```
sudo /usr/pgsql-10/bin/postgresql-10-setup initdb
```
4. Open /var/lib/pgsql/data/pg_hba.conf file to change the authentication to md5.
```
sudo vi /var/lib/pgsql/10/data/pg_hba.conf
```
5. Find the following lines at the bottom of the file and change 'peer' to 'trust' and 'idnet' to 'md5'
```
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
host    all             all             127.0.0.1/32            ident
# IPv6 local connections:
host    all             all             ::1/128                 ident
```
6. Start and enable PostgreSQL.
```
sudo systemctl start postgresql-10
sudo systemctl enable postgresql-10
```
7. You can verify the installation using the following version select query.
```
sudo -u postgres /usr/pgsql-10/bin/psql -c "SELECT version();"
```
## Setup Sonar User and Database
1. Change the default password of the Postgres user. All Postgres commands have to be executed from this user.
```
sudo passwd postgres
```
2. Login as postgres user with the new password.
```
su - postgres
```
3. Login to the PostgreSQL CLI.
```
psql
```
4. Create a sonarqubedb database.
```
create database sonarqubedb;
```
5. Create the sonarqube DB user with a strongly encrypted password. Replace your-strong-password with a strong password.
```
create user sonarqube with encrypted password 'your-strong-password';
```
6. Next, grant all privileges to sonrqube user on sonarqubedb.
```
grant all privileges on database sonarqubedb to sonarqube
```
7. Exit the psql prompt using the following command.
```
\q
```
8. Switch to your sudo user using the exit command.
```
exit
```
## Setup Sonarqube Web Server
1. Download the latest sonarqube installation file to /opt folder. You can get the latest download link from here. http://www.sonarqube.org/downloads/
```
cd /opt 
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.6.1.59531.zip
```
2. Unzip sonarqube source files and rename the folder.
```
sudo unzip sonarqube-7.6.zip
sudo mv sonarqube-7.6 sonarqube
```
3. Open /opt/sonarqube/conf/sonar.properties file.
#### Uncomment and edit the parameters as shown below. Change the password accordingly. You will find jdbc parameter under PostgreSQL section
```
sudo vi /opt/sonarqube/conf/sonar.properties

sonar.jdbc.username=sonar                                                                                                
sonar.jdbc.password=sonar-db-password
sonar.jdbc.url=jdbc:postgresql://localhost/sonar
```
4. By default, sonar will run on 9000. If you want on port 80 or any other port, change the following parameters for accessing the web console on that specific port.
```
sonar.web.host=0.0.0.0
sonar.web.port=80
```
If you want to access sonarqube some path like http://url:/sonar, change the following parameter.
```
sonar.web.context=/sonar
```
## Add Sonar User and Privileges
1. Create a user named sonar and make it the owner of the /opt/sonarqube directory
```
sudo useradd sonar
sudo chown -R sonar:sonar /opt/sonarqube
```
## Start Sonarqube Service
1. Login as sonar user
```
sudo su - sonar
```
2. Navigate to the start script directory.
```
cd /opt/sonarqube/bin/linux-x86-64
```
### Note: Donot start sonarqube with root user as its internally use elastic search
edit file sonarqube-9.5.0.56709/bin/linux-x86-64/sonar.sh
```
vi sonarqube-9.5.0.56709/bin/linux-x86-64/sonar.sh
RUN_AS_USER=ubuntu
```
3. Start the sonarqube service.
```
./sonar.sh start
```
##### Note Now, you should be able to access sonarqube on the browser on port 9000

4. Check the application status. If it is in running state, you can access the sonarqube dashboard using the DNS name or Ip address of your server.
```
sudo ./sonar.sh status
```

## Setting up Sonarqube as a service
1. Create a file /etc/systemd/system/sonarqube.service
```
sudo vi /etc/systemd/system/sonarqube.service
```
2. Copy the following content on to the file.
```
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=simple
User=sonarqube
Group=sonarqube
PermissionsStartOnly=true
ExecStart=/bin/nohup java -Xms32m -Xmx32m -Djava.net.preferIPv4Stack=true -jar /opt/sonarqube/lib/sonar-application-7.6.jar
StandardOutput=syslog
LimitNOFILE=65536
LimitNPROC=8192
TimeoutStartSec=5
Restart=always

[Install]
WantedBy=multi-user.target
```
3. Start and enable sonarqube
```
sudo systemctl start sonarqube
sudo systemctl enable sonarqube
```
4. Check the sonarqube status to ensure it is running as expected.
```
sudo systemctl status  sonarqube
```
*******************

# Troubleshooting Sonarqube
### Ref: https://www.sonarqube.org/community/
### All the logs of sonarqube are present in the /opt/sonarqube/logs directory.
```
cd /opt/sonarqube/logs
```
### You can find the following log files.
```
es.log
sonar.log
web.log
access.log
```
### Using tail command you can check the latest logs. For example,
```
tail -f access.log
```
****************************************************************************

### export bin to path
```
export PATH=$PATH:<full path>
```
### Note: Donot start sonarqube with root user as its internally use elastic search
edit file sonarqube-9.5.0.56709/bin/linux-x86-64/sonar.sh
```
vi sonarqube-9.5.0.56709/bin/linux-x86-64/sonar.sh
RUN_AS_USER=ubuntu

### Start sonar
```
cd sonarqube-9.5.0.56709/bin/linux-x86-64
sh sonar.sh start
```

### Default login is 
```
admin
admin
```


***********************************************
# Integrate sonar with Maven

Dowanload sonar scanner
https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/

plugin
<plugin>
    <groupId>org.sonarsource.scanner.maven</groupId>
    <artifactId>sonar-maven-plugin</artifactId>
    <version>3.9.1.2184</version>
</plugin>

for global use in seting.xml file and for particular project pom.xml


to get the latest version of plugin
https://mvnrepository.com/artifact/org.sonarsource.scanner.maven/sonar-maven-plugin

to check code quality
```
mvn sonar:sonar -Dsonar.host.url=<sonar server url>:9000 -Dsonar.login=<sonar generated token>
mvn sonar:sonar -Dsonar.host.url=http://3.110.212.149:9000 -Dsonar.login=squ_b0d3a773c07c947a47be79e8be84813db5bbdac1
```

*************************************************************
sonnnar scanner conf file

sonar.host.url=http://localhost:9000
sonar.sourceEncoding=UTF-8
sonat.jdbc.username=sonar
sonat.jdbc.password=sonar

sonar.jdbc.url=jdbc:postgresql://localhost/sonar         mysql oracle jtds:sqlserver 

sonar.projectKey=Javaproject
sonar.projectName=JavaProject
sonar.projectversion=
sonar.sources=


Run SonarQube

sonar/bin
```
startSonar.bat
```

JavaProject folder
```
sonar-runner.bat
```


**************************************
# Postgress SQL Database for SOnarqube

## install postgress13 vim epel  postgresql-server postgresql-devel
Ref - https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-20-04-quickstart

## initalize the db
```
/use/bin/postgresql-setup --init
systemctl start postgresql
systemctl enable postgrsql
```
## use postgres db
```
su - postgres
psql
##reset the password
\password postgres
```

## Create database
crwate database <db name>;

## Create db user
create user sonaruser with encrypted password 'password#123!';

## privileges
grant all privileges on database <db name> to <username>;

##  to exit
\q

## after configure restart the DB
*****************
# edit below mention file to link sonar and psql db
```
vi sonarqube-9.5.0.56709/conf/sonar.properties
    sonar.jdbc.username=<db username>
    sonar.jdbc.password=<password>
    sonar.jdbc.url=jdbc:postgresql://localhost/<db name>
```
## change authentication types
```
cd /var/lib/psql/data
vi pg_hba.conf
    # "local" is for Unix domain socket connections only
    local   all         all             md5
    # IPv4 local connections:
    loca    all         0.0.0.0/0       md5
```
## restart postgresql
```
systemctl restart postgressql.service
```  

## restart sonar
```
sh sonar.sh start
```
*****************************
# Incrrase vm.max_map_count

## To get the value
sysctl -w vm.max_map_count

## To update the value
sysctl -w vm.max_map_count=25648

## to make permanent change, edit below file
```
vi /etc/sysctl.conf
```
***********************************
Checkstyle

check- bugs, vulnerability, standards, leaksof memroy, connection
install checkstyle plugin into Visula Studio

Quality

Internal - quality 
UcDetector, Checkstyle, FindBugs, Emma

External- Functional Requiremtn & Specification
HP+ALM
Jira
MS team foundarion server


Testing

Dynamic
dev -> Code -> Run -> Test -> Report   (unit, integration, regression)
CasperJS, Selenium, Sahi

Static
Dev -> Code -> testing -> analysis -> Report
SonarQube, Apache-Yatus, CodeDx, CodeSense

*************************************
***************************************
Maven
settings.xml
Download Plugin
<pluginGroup>org.sonarsource.scanner.maven</pluginGroup>

<profile>
    <id>sonar</id>
    <activation>
    <activeByDefault>true</activeByDefault>
    </activation>
    <properties>
    <sonar.host.url>
        http://localhost:9000
    </sonar.host.url>
    <sonar.login>f2c5796ab53a586946b7941310a166390b347db1</sonar.login>
    </properties>
</profile>

```
mvn sonar:sonar -Dsonar.login=f2c5796ab53a586946b7941310a166390b347db1 -Dsonar.
```
f2c5796ab53a586946b7941310a166390b347db1
17af4dd3208c76f2da5341a76be6b7b44771ff2f

******************************************
# Gradle
build.gradle
```
plugins {
	id 'org.springframework.boot' version '2.5.4'
	id 'io.spring.dependency-management' version '1.0.11.RELEASE'
	id 'java'
	id 'war'
	id 'org.sonarqube' version '3.3'
}
sonarqube {
    properties {
        property 'sonar.host.url', 'http://3.110.136.39'
        property 'sonar.login', '******'
    }
}
```
locally
```
gradle clean
gradle sonarqube
```
********************************
Code Coverage Report

gradle 

plugins {
    id 'jacoco'
}
********************************
Find Bugs

*********************************
Create Webhook for quality gate report


**************************************
Sonarqube and jenkins

install plugin sonarqube scanner plugins
add sonar toekn as secret text in jenkins credential
configure tool add sonarqube server
Create webhook to revert the status of qua;ity check to jenkins

sonarqube-administration-configuration-webook- name-jenkins
                                                url- <jenkins url>:8080/sonarqube-webhook/