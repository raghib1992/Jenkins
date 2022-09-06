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
# Install Gradle on Window
## Ref https://gradle.org/install/
## Downaload binaries
## Extract the bin zip file
## set the GRADLE_HOME and path in user env and system env variable
**********************************

.gradle

in window 
C:\Users\raghi\.gradle
store all the dependencies and jar file

gradle plugins for eclipse IDE
Help -> Eclipse Market Place -> Buildship Gralde Integration
File -> other ->Gradle -> Gradle Project

**********************************************

# Gradle Task
### Create Gradle Workspace
```
C:\MyWorkspace>gradle init
Starting a Gradle Daemon (subsequent builds will be faster)

Select type of project to generate:
  1: basic
  2: application
  3: library
  4: Gradle plugin
Enter selection (default: basic) [1..4] 2

Select implementation language:
  1: C++
  2: Groovy
  3: Java
  4: Kotlin
  5: Scala
  6: Swift
Enter selection (default: Java) [1..6] 3

Split functionality across multiple subprojects?:
  1: no - only one application project
  2: yes - application and library projects
Enter selection (default: no - only one application project) [1..2] 1

Select build script DSL:
  1: Groovy
  2: Kotlin
Enter selection (default: Groovy) [1..2]

Generate build using new APIs and behavior (some features may change in the next minor release)? (default: no) [yes, no]

Select test framework:
  1: JUnit 4
  2: TestNG
  3: Spock
  4: JUnit Jupiter
Enter selection (default: JUnit Jupiter) [1..4] 4

Project name (default: MyWorkspace): MyProject
Source package (default: MyProject): MyPackage

> Task :init
Get more help with your project: https://docs.gradle.org/7.3.3/samples/sample_building_java_applications.html

BUILD SUCCESSFUL in 8m 54s
2 actionable tasks: 2 executed
```
### Task
#### Build
```
C:\MyWorkspace>gradle build

BUILD SUCCESSFUL in 23s
7 actionable tasks: 7 executed
C:\MyWorkspace>
```

*********************************
# Command
```
gradle clean build --info
```
****************************
# Gradle and Nexus Integration


#### Gradle 6 for nexus support http and https
#### Gradle 7 for nexus support https

### vi build.gradle
```
sonarqube {
    properties {
        property "sonar.sourceEncoding", "UTF-8"
                property "sonar.projectName", "springboot-tomcat-gradle-war"
                property "sonar.host.url", "http://13.235.83.230:9000"
                property "sonar.login", "squ_88e2bec6a384f126b4d4bba53e303bdeac671e1e"
    }
}
```

## TO Create Artifacts 
## gralde command 
```
gradle clean build
```

## To push artifacts to nexus
### Plugin
#### Ref https://medium.com/@simionrazvan/how-to-create-a-gradle-library-and-publish-it-on-nexus-34be19b520aa
```
apply plugin: ‘maven-publish’
```
```
publishing {
  publications {
    maven(MavenPublication) {
	// bootJar is the default build task configured by spring boot
	artifact bootJar
    }
  }
  repositories {
    maven {
      if(project.version.endsWith('-SNAPSHOT')) {
        url 'http://65.0.74.168:8081/repository/maven-snapshots/'
      } else {
        url 'http://65.0.74.168:8081/repository/maven-releases/'
      }
      credentials {
        username "admin"
        password "nexus123"
      }
    }
  }
}
```

*********************
# Add Nexus credential in gradle.properties
## add build.gradle
```
publishing {
  publications {
    maven(MavenPublication) {
	// bootJar is the default build task configured by spring boot
	artifact bootJar
    }
  }
  repositories {
    maven {
      if(project.version.endsWith('-SNAPSHOT')) {
        url 'http://65.0.74.168:8081/repository/maven-snapshots/'
      } else {
        url 'http://65.0.74.168:8081/repository/maven-releases/'
      }
      credentials {
        username project.repoUser
        password project.repoPassword
      }
    }
  }
}
```

### vi gradle.properties
```
repoUser=admin
repoPassword=nexus123
```

**************
# Download the artifacts from maven

```
wget --user <sonar username> --password <sonar password> <nexus repo url>/<artifacts path>
```