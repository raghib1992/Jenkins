# Jenkins on Ubuntu 

## To install Java SE development Kit
## Install JAVA
```
sudo apt update
sudo apt search openjdk
```
#### pick any one from the output
```
sudo apt install openjdk-11-jdk
java -version
```
## Configure Java_Home on Linux:
### get the path
```
cd /usr/lib/jvm/
```
### Login to your account and open the startup script file which is usually ~/.bash_profile  file (or can be .bashrc depending on your envrionment settings)
```
vi ~/.bash_profile
export JAVA_HOME=<path from above location>
export PATH=$HOME:$JAVA_HOME/bin
```

#### Forc shell and bourne shell
```
C shell:

setenv JAVA_HOME jdk-install-dir
setenv PATH $JAVA_HOME/bin:$PATH
export PATH=$JAVA_HOME/bin:$PATH

Bourne shell:

JAVA_HOME=jdk-install-dir
export JAVA_HOME
PATH=$JAVA_HOME/bin:$PATH
export PATH
```

### Type the following command to activate the new path settings immediately:
```
source ~/.bash_profile 
```

### Verify new settings:
```
echo $JAVA_HOME
echo $PATH
```
## Install Jenkins
```
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
```
### Start Jenkins
```
sudo systemctl start jenkins
sudo systemctl status jenkins
```
******************************
## If an error is reported, “jenkins : Depends: daemon but it is not installable”, add the "universe" apt repository of community maintained free and open source software for Ubuntu by executing this command after sudo apt-get update:
```
sudo add-apt-repository universe
```
************************************************
# Install maven
download Maven Integration plugins
download git plugins

## location of workspce
 /var/jenkins_home/workspace

# install tomcat container

# install copy artifact plugins
# install deploy to container


## for ssh setting in jenkins
configure system

## install ansible plugins
## install ansicolor
********************

# FOr multibranch project
## Branch Filter- allow only dev and master and feature branch but not to bug fixing branch
### Filter by name (with regular expression)
```
^dev|master|feature.*$
```

*******************************************

Install plugins "maven integration"
********************************************

Jenkins push file docker image to ECR

plugin CLoudBees aws credentials
plugin amazon ecr
plugin docker pipeline

********************************************

Email notification from jenkins to ses

AWS 
create email 
SMTP crdential

Jenkins
ses endpoint
username
passord
use ssl and tls
port 465
UTF-8
*************************************
install on


*************************************

# Security


### vi /var/lib/jenkins/config.xml
```
  <useSecurity>true</useSecurity>
  <authorizationStrategy class="hudson.security.FullControlOnceLoggedInAuthorizationStrategy">
    <denyAnonymousReadAccess>true</denyAnonymousReadAccess>
  </authorizationStrategy>
```