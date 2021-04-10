# Jenkins on Ubuntu 

## To install Java SE development Kit
# Configure Java_Home on Linux:
# Login to your account and open the startup script file which is usually ~/.bash_profile  file (or can be .bashrc depending on your envrionment settings)
$ vi ~/.bash_profile

# In the startup script, set JAVA_HOME  and PATH 
# Ignore c shell and bourne shell
                        C shell:

                        setenv JAVA_HOME jdk-install-dir
                        setenv PATH $JAVA_HOME/bin:$PATH
                        export PATH=$JAVA_HOME/bin:$PATH

  



                        Bourne shell:

                        JAVA_HOME=jdk-install-dir
                        export JAVA_HOME
                        PATH=$JAVA_HOME/bin:$PATH
                        export PATH


# Korn and bash shells:

export JAVA_HOME=jdk-install-dir
export PATH=$JAVA_HOME/bin:$PATH


# Type the following command to activate the new path settings immediately:
$ source ~/.bash_profile 

# Verify new settings:
$ echo $JAVA_HOME
$ echo $PATH

# is the JDK installation director, which should be something similar to /usr/java/jdk1.5.0_07/bin/java
jdk-install-dir

## Install JAVA
sudo apt update
sudo apt search openjdk
sudo apt install openjdk-11-jdk
sudo apt install openjdk-11-jdk
java -version



## Install Jenkins
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins

# If an error is reported, “jenkins : Depends: daemon but it is not installable”, add the "universe" apt repository of community maintained free and open source software for Ubuntu by executing this command after sudo apt-get update:
        sudo add-apt-repository universe



## Install maven
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