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
M2=/opt/maven/bin
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.13.0.8-1.amzn2.0.3.x86_64
PATH=:$M2:$M2_HOME:$JAVA_HOME/bin
```
### to update path
```
source .bash_profile
```


*********************************
# On Jenkins side

## Install maven plugins
### install plugin 'Maven Integration'

## Configure maven and java
### configure into "Global Tool Configuration"
#### maven - name and path:/opt/maven
#### jdk - name and path:/usr/lib/jvm/java-11-openjdk-11.0.13.0.8-1.amzn2.0.3.x86_64
*********************************


# maven goal
## ref for maven lifecycle to set maven goal is:
```
https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html
https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html#Lifecycle_Reference
```
*****************************
# Sonar Analysis
## add plgin into pom file

# Soanrqube and Maven server Integration
## download plugins
Ref- https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-maven/
Ref- https://mvnrepository.com/artifact/org.sonarsource.scanner.maven/sonar-maven-plugin

```
    <plugin>
        <groupId>org.sonarsource.scanner.maven</groupId>
        <artifactId>sonar-maven-plugin</artifactId>
        <version>3.9.1.2184</version>
    </plugin>
```
## Generate sonar-token 
```
mvn sonar:sonar -Dsonar.host.url=http://13.235.75.152:9000 -Dsonar.login=squ_9a7dc4c18041b949520a18f31a1d8eef089142c1
```


# Logger

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;