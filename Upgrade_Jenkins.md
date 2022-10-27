# Upgrade Jenkins

## Steps
1. To make down time to zero, create AMI of current server
    - EC2-->Instance-->Action-->Image and Templates-->Create Image
    - Note: Select No Reboot
2. Create a ec2 instance
    - Create EC2 instance in the same vpc and subnet.
    - Select AMI, created in step 1.
    - Select same instance type.
    - Attach same security group, IAM role ans SSH key.
    - Same tags as in old jenkins server.
3. Take backup of current jenkins.war, config.xml and plugins
    - Login into New_Jenkins server
    - Get the backup of jenkins.war file
    ```
    cd /usr/share/jenkins/
    cp jenkins.war ~/jenkins.war_bck
    ```
    - Create the backup of config.xml file
    ```
    cd /var/lib/jenkins
    cp config.xml ~/config.xml_bck
    ```
    - Create backup of plugins
    ```
    cd ~
    mkdir old_plugins
    cp -r /var/lib/jenkins/plugins ./old_plugins/
    ```
4. Stop the jenkins.service
    ```
    systemctl stop jenkins
    ```
5. Install Latest jenkins
    - Download lastest jenkins.war file and replace with old jenkins.war file.
    ```
    cd ~
    wget https://updates.jenkins.io/download/war/2.369/jenkins.war
    cd /usr/share/jenkins
    rm jenkins.war
    cp ~/jenkins.war .
    ```
6. Update Java
    - check java version
    ```
    java -version
    ```
    - If Java version is not 11, then 
    ```
    sudo add-apt-repository ppa:openjdk-r/ppa
    sudo apt-get update
    sudo apt install openjdk-11-jdk
    ```
    - Change java config
    ```
    update-alternatives --config java
    ## select the serial number for java 11
    ```
    - Check java version again to confirm
7. Remove all old plugins
    ```
    cd /var/lib/jenkins/plugins
    rm -rf ./*
    ```
8. Reset config.xml file
    - config.xml contain Role and Assign detials, to reset all the setting. Replace config.xml with following data
```
<?xml version='2.1' encoding='UTF-8'?>
<hudson>
  <disabledAdministrativeMonitors/>
  <version>2.369</version>
  <numExecutors>2</numExecutors>
  <mode>NORMAL</mode>
  <useSecurity>true</useSecurity>
  <authorizationStrategy class="com.michelin.cio.hudson.plugins.rolestrategy.RoleBasedAuthorizationStrategy">
    <roleMap type="projectRoles"/>
    <roleMap type="globalRoles">
      <role name="admin" pattern=".*">
        <permissions>
          <permission>hudson.model.Hudson.Administer</permission>
        </permissions>
        <assignedSIDs>
          <sid>nadim</sid>
        </assignedSIDs>
      </role>
    </roleMap>
    <roleMap type="slaveRoles"/>
  </authorizationStrategy>
  <securityRealm class="hudson.security.HudsonPrivateSecurityRealm">
    <disableSignup>true</disableSignup>
    <enableCaptcha>false</enableCaptcha>
  </securityRealm>
  <disableRememberMe>false</disableRememberMe>
  <projectNamingStrategy class="jenkins.model.ProjectNamingStrategy$DefaultProjectNamingStrategy"/>
  <workspaceDir>${JENKINS_HOME}/workspace/${ITEM_FULL_NAME}</workspaceDir>
  <buildsDir>${ITEM_ROOTDIR}/builds</buildsDir>
  <markupFormatter class="hudson.markup.EscapedMarkupFormatter"/>
  <jdks/>
  <viewsTabBar class="hudson.views.DefaultViewsTabBar"/>
  <myViewsTabBar class="hudson.views.DefaultMyViewsTabBar"/>
  <clouds/>
  <scmCheckoutRetryCount>0</scmCheckoutRetryCount>
  <views>
    <hudson.model.AllView>
      <owner class="hudson" reference="../../.."/>
      <name>all</name>
      <filterExecutors>false</filterExecutors>
      <filterQueue>false</filterQueue>
      <properties class="hudson.model.View$PropertyList"/>
    </hudson.model.AllView>
  </views>
  <primaryView>all</primaryView>
  <slaveAgentPort>-1</slaveAgentPort>
  <label></label>
  <crumbIssuer class="hudson.security.csrf.DefaultCrumbIssuer">
    <excludeClientIPFromCrumb>false</excludeClientIPFromCrumb>
  </crumbIssuer>
  <nodeProperties/>
  <globalNodeProperties/>
  <nodeRenameMigrationNeeded>false</nodeRenameMigrationNeeded>
</hudson>
```
9. start the jenkins.service
    ```
    systemctl start jenkins
    ```
10. Log into Jenkins console
    - Use old usename and password
11. Install Role based authorization plugins
    - Install Role Based authorization plugins from plugins manager
12. revert the config.xml file
    - get the old config.xml from your backup
    ```
    systemctl stop jenkins
    cd /var/lib/jenkins
    cp config.xml ~/config.xml_bck_new
    rm config.xml
    cp ~/config.xml_bck ./config.xml
    chown enkins:jenkins config.xml
    systemctl start jenkins
    ```
    - Relogin into jenkins to confirm everything is ok and as per your plan
13. Restore all the plugins back
    - Backup of current plugins folder
    ```
    systemctl stop jenkins
    mkdir ~/new_plugins
    cp /var/lib/jenkins/plugins ~/new_plugins
    ```
    - Replace new_plugins into old_plugins
    ```
    cd ~/old_plugins/plugins
    rm -rf role*
    cd ~/new_plugins/plugins/
    cp ./* ~/old_plugins/plugins
    ```
    - Restore back all plugins
    ```
    cd ~/old_plugins/plugins /var/lib/jenkins
    chown jenkins:jenkins -R plugins/
    ```
    - Restart jenkins service
    ```
    systemctl start jenkins
    ```
16. Update all the plugins
    - login into jenkins
    - Go to plugin manager
    - update all plugins
    - restart Jenkins


