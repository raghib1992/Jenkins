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
Setup Sonarqube server

Downlaod sonarqube
https://www.sonarqube.org/downloads/
https://www.sonarqube.org/success-download-community-edition/


Dowanload sonar scanner
https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/

Set env variable for sonar scanner


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
