There are basically two ways to configure email notifications in Jenkins.

1. Using Email Extension Plugin 
-  Install Email Extension Plugin
- Now go to Manage Jenkins-> Configure System. 
    - For  Gmail -> smtp.gmail.com for the SMTP server. 
    - Click on Advanced and select Use SMTP authentication. Enter your Gmail username and password.
    - Select the Use SSL option and enter the port number as 465. Click on Apply and then Save
- Create Jenkins Pipeline Job
```
post {
        always {
            emailext body: 'A Test EMail', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: 'Test'
            mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "${currentBuild.result} CI: Project name -> ${env.JOB_NAME}", to: "deekshith.snsep@gmail.com";
        }
    }
```
2. Using Default Email Notifier