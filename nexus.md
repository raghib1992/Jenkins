# Nexus

## Ref Documentation
```
https://help.sonatype.com/repomanager3/product-information/system-requirements
```

## Pre-requisite
- minimum 1 VCPU & 2 GB Memory
- Server firewall opened for port 22 & 8081
- OpenJDK 8
- All Nexus processes should run as a non-root nexus user

## Install Nexus
#### Ref
```
https://help.sonatype.com/repomanager3/product-information/download
https://download.sonatype.com/nexus/3/nexus-3.40.1-01-unix.tar.gz
```

1. Login to your Linux server and update the yum packages. Also install required utilities.
```
sudo yum update -y
sudo yum install wget -y
```
2. Install OpenJDK 1.8
```
sudo yum install java-1.8.0-openjdk.x86_64 -y
```
3. Create a directory named app and cd into the directory.
```
sudo mkdir /app && cd /app
```
4. Download the latest nexus. You can get the latest download links fo for nexus from here.
```
sudo wget -O nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz
```
5. Untar the downloaded file.
```
sudo tar -xvf nexus.tar.gz
```
6. Rename the untared file to nexus.
```
sudo mv nexus-3* nexus
```
7. As a good security practice, it is not advised to run nexus service with root privileges. So create a new user named nexus to run the nexus service.
```
sudo adduser nexus
```
8. Change the ownership of nexus files and nexus data directory to nexus user.
```
sudo chown -R nexus:nexus /app/nexus
sudo chown -R nexus:nexus /app/sonatype-work
```
9. Open /app/nexus/bin/nexus.rc file
### Uncomment run_as_user parameter and set it as following.
```
sudo vi  /app/nexus/bin/nexus.rc

run_as_user="nexus"
```
## Note For Prod Server

#### If you want to change the default nexus data directory, open the nexus properties file and change the data directory -Dkaraf.data parameter to a preferred location as shown below. If you don’t specify anything, by default nexus data directory will be set to /app/sonatype-work/nexus3

#### Tip: For production setup, it is is always better to mount the nexus data directory to a separate data disk attached to the server. So that backup and restore can be done easily.
```
sudo vi /app/nexus/bin/nexus.vmoptions
```

### Running Nexus as a System Service
#### It is better to have systemd entry to manage nexus using systemctl
1. Create a nexus systemd unit file.
```
sudo vi /etc/systemd/system/nexus.service
```
2. Add the following contents to the unit file.
```
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/app/nexus/bin/nexus start
ExecStop=/app/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
```
3. Execute the following command to add nexus service to boot
```
sudo chkconfig nexus on
```
4. To start the Nexus service
```
sudo systemctl start nexus
```
### To log in
1. Default username is
```
admin
```
2. find the default admin password
```
cat /app/sonatype-work/nexus3/admin.password
```

*********************************************

# Sonatype Nexus not Starting [Troubleshooting]
Sometimes, if the server is enabled with SELINUX, you might get the following error. (Commonly on Centos Servers)

Job for nexus.service failed because the control process exited with error code.
See "systemctl status nexus.service" and "journalctl -xe" for details.

Execute the following command and see the actual error.
```
journalctl -xe
```
Check the output for the following SELINUX issue.

SELinux is preventing /usr/lib/systemd/systemd from execute access on the file nexus.
To rectify this issue, add a SELinux policy to allow Systemd to access the nexus binary in path /app/nexus/bin/nexus using the following command.
```
sudo chcon -R -t bin_t /app/nexus/bin/nexus
```
Now, start the Nexus server again.
```
sudo systemctl start nexus
```
****************************************88
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



