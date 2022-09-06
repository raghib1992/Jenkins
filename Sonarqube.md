
# Setup Sonarqube server

## pre-requisites

### install java-11

### ubuntu
```
apt install openjdk-11-jre-headless -y
apt install openjdk-11-jdk-headless -y
```

### Downlaod sonarqube
#### Ref:
```
https://www.sonarqube.org/downloads/
https://www.sonarqube.org/success-download-community-edition/
https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.5.0.56709.zip
``` 

### export bin to path
```
export PATH=$PATH:<full path>
```
### Note: Donot start sonarqube with root user as its internally use elastic search
edit file sonarqube-9.5.0.56709/bin/linux-x86-64/sonar.sh
```
vi sonarqube-9.5.0.56709/bin/linux-x86-64/sonar.sh
RUN_AS_USER=ubuntu
```

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