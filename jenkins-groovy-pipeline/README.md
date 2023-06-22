# Install jenkins in Container
## create jenkins image
docker build -t myjenkins .

## Create network
docker netowrk create jenkins


## Create docker container
docker run --name jenkins --restart=on-failure --detach `
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 `
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 `
  --volume jenkins-data:/var/jenkins_home `
  --volume jenkins-docker-certs:/certs/client:ro `
  --publish 8080:8080 --publish 50000:50000 myjenkins:4

# Create alpine container to run slave container inside it
## Alpine socat container
docker run -d --restart=always -p 127.0.0.1:2376:2375 --network jenkins -v /var/run/docker.sock:/var/run/docker.sock alpine/socat tcp-listen:2375,fork,reuseaddr unix-connect:/var/run/docker.sock

## get the aline container ip
docker inspect <container_id> | grep IPAddress

# create docker cloud node
1. install plugins docker
2. manage plugins - manage nodes and cloud
3. configure cloud



# Integrate aws and Jenkins
1. Install cloudbees aws credentials
2. create credentials in jenkins (aws credentials)
3. pipeline script
```
pipeline {
    agent any
    stages{
        stage('aws s3 list'){
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-credentials',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                      sh 'aws s3 ls'
                }
            }
        }
    }
}
```


# aws configure cloud
1. install plugins Amazon EC2
2. COnfigure cloud
