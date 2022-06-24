# Deploy artifact to tomcat server using ssh server
Download plugin ssh agent


*******************************
Add Credential
***************************
# Tomcat on Window Machine
Set-Item WSMan:\localhost\Client\TrustedHosts *
Set-ExecutionPolicy RemoteSigned –Force
install a new plugin named EnvInject Plugin for transferring variables e.g. passwords
************************************************

https://hodgkins.io/automating-with-jenkins-and-powershell-on-windows-part-1
https://hodgkins.io/automating-with-jenkins-and-powershell-on-windows-part-2
https://techexpert.tips/powershell/powershell-copy-files-remote-computers/

Client
Enable-PSRemoting -Force


Domain Server
Test-WSMan <client IP>
Enter-PSSession -ComputerName 172.31.9.223 -Credential <username>

curl -u admin:Jfrog@123 -XGET http://3.110.227.79:8081/artifactory/webapp/#/artifacts/browse/tree/General/nadim-local/sampleWeb-0.0.3-SNAPSHOT.war --output pilot-mdm.war