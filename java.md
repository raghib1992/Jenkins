# Install Java on Window
## Ref https://www.oracle.com/java/technologies/downloads/#jdk17-windows
## Install using console
## Set user and system variable
```
JAVA_HOME=C:\Program Files\Java\jdk-17.0.2
```
## Set system path
```
%JAVA_HOME%\bin
```


# Install Java on Linux
vi /etc/profile
    ## JAVA ENV
    export JAVA_HOME=/path of jdk file
    export PATH=$JAVA_HOME/bin:$PATH


source /etc/profile
echo $JAVA_HOME
