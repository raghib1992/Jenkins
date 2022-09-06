# Trigger Job from Bash Script

## Install plugins
### 1. Strict Crumb Issue

### Go to Manage Jenkins -> Configure Global Security -> CSRF Protection.

### Select Strict Crumb Issuer.

### Click on Advanced.

### Uncheck the Check the session ID box.

### Save it.

## Get crumb token
```
crumb=$(curl -s -u admin:admin 'http://localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
```
## Run the build
```
curl -X POST http://13.233.204.196:8080/job/ENV/build?delay=0sec --user admin:admin -H $crumb
```

## Run the build with Paramter
```
curl -u "jenkins:1234" -H "$crumb" -X POST  http://jenkins.local:8080/job/backup-to-aws/buildWithParameters?MYSQL_HOST=db_host&DATABASE_NAME=testdb&AWS_BUCKET_NAME=jenkins-mysql-backup
```

https://ptsv2.com/t/qrjtp-1655355770/post'

curl -X POST https://ptsv2.com/t/qrjtp-1655355770/post --user admin:admin -H $crumb