# Run Jfrog Artifact and setup the Admin
# Use Git to get the sample code
# Install Maven to compile and Package the sample code
# Connect Maven to JFrog
# Check how the versioning works on JFrog

********************************************
# Create repo
## Local
## Remote
## Virtual
raghib-virtual-repo/
********************************************
# Create User
## user and password with privlage
********************************************
# Add Distribution elements (which contain add of repo to deploy) to pom.xml
```
distributionManagement>
    <repository>
        <id>central</id>
        <name>ip-172-31-16-251.ap-south-1.compute.internal-releases</name>
        <url>http://ec2-52-66-232-53.ap-south-1.compute.amazonaws.com:8081/artifactory/raghib-local-repo</url>
    </repository>
    <snapshotRepository>
        <id>snapshots</id>
        <name>ip-172-31-16-251.ap-south-1.compute.internal-snapshots</name>
        <url>http://ec2-52-66-232-53.ap-south-1.compute.amazonaws.com:8081/artifactory/raghib-local-repo</url>
    </snapshotRepository>
</distributionManagement>
```
********************************************
# Modify setting.xml and add server elements of accessing a repo
```
<?xml version="1.0" encoding="UTF-8"?>
<settings xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd" xmlns="http://maven.apache.org/SETTINGS/1.1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <servers>
    <server>
      <username>raghib</username>
      <password>node@123</password>
      <id>central</id>
    </server>
    <server>
      <username>raghib</username>
      <password>node@123</password>
      <id>snapshots</id>
    </server>
  </servers>
  <profiles>
    <profile>
      <repositories>
        <repository>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
          <id>central</id>
          <name>raghib-virtual-repo</name>
          <url>http://ec2-52-66-232-53.ap-south-1.compute.amazonaws.com:8081/artifactory/raghib-virtual-repo</url>
        </repository>
        <repository>
          <snapshots />
          <id>snapshots</id>
          <name>raghib-virtual-repo</name>
          <url>http://ec2-52-66-232-53.ap-south-1.compute.amazonaws.com:8081/artifactory/raghib-virtual-repo</url>
        </repository>
      </repositories>
      <pluginRepositories>
        <pluginRepository>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
          <id>central</id>
          <name>raghib-virtual-repo</name>
          <url>http://ec2-52-66-232-53.ap-south-1.compute.amazonaws.com:8081/artifactory/raghib-virtual-repo</url>
        </pluginRepository>
        <pluginRepository>
          <snapshots />
          <id>snapshots</id>
          <name>raghib-virtual-repo</name>
          <url>http://ec2-52-66-232-53.ap-south-1.compute.amazonaws.com:8081/artifactory/raghib-virtual-repo</url>
        </pluginRepository>
      </pluginRepositories>
      <id>artifactory</id>
    </profile>
  </profiles>
  <activeProfiles>
    <activeProfile>artifactory</activeProfile>
  </activeProfiles>
</settings>
```
*********************************************************
# deploy
```
mvn deploy
```
**********************************************************
**********************************************************
# Create Group repo which contain all the repo from where you download the package
### Get group repo url
**********************************************************
# Locate the package required for dowanload
### Add Dependencies
**********************************************************
# delete from local maven repwo
**********************************************************
# Modify setting.xml with add mirror elements with Group Repo
### id must be match with server elemets
```
<mirrors>
    <mirror>
     <id>cental</id>
     <name>artifactory-group-repo</name>
     <url>http://ec2-52-66-232-53.ap-south-1.compute.amazonaws.com:8081/artifactory/raghib-virtual-repo</url>
     <mirrorOf>*<mirrorOf>
    <mirror>
<mirrors>

**********************************************************

