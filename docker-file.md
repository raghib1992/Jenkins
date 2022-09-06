# Install Docker
yum install docker -y

# Dockerfile
```
FROM java:8
COPY <src-path> <destination path>
COPY target/springboot-maven-course-micro-svc-0.0.1-SNAPSHOT.jar app.jar    # to rename the artufact
ENTRYPOINT ["java", "-jar", "app.jar"]                                      # to set the executables to container
```

# Create Repository in aws ECR 
ECR
repo name
create rep name

# Creat a role for EC2 instance to access ECR

policy
AmazonEC2ContainerRegistryFullAccess
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
}
```

## Push Command on mac/linux

### Make sure that you have the latest version of the AWS CLI and Docker installed. For more information, see Getting Started with Amazon ECR .

### Use the following steps to authenticate and push an image to your repository. For additional registry authentication methods, including the Amazon ECR credential helper, see Registry Authentication .

### Step1: Retrieve an authentication token and authenticate your Docker client to your registry.
#### Use the AWS CLI:
```
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 561243041928.dkr.ecr.ap-south-1.amazonaws.com
```

#### Note: If you receive an error using the AWS CLI, make sure that you have the latest version of the AWS CLI and Docker installed.

### Step2: Build your Docker image using the following command. For information on building a Docker file from scratch see the instructions here . You can skip this step if your image is already built:
```
docker build -t myapp .
```

### Step 3: After the build completes, tag your image so you can push the image to this repository:
```
docker tag myapp:latest 561243041928.dkr.ecr.ap-south-1.amazonaws.com/myapp:latest
```
### Step 4: Run the following command to push this image to your newly created AWS repository:
```
docker push 561243041928.dkr.ecr.ap-south-1.amazonaws.com/myapp:latest
```
******************************************************************************
## Push Command on Window

### Make sure that you have the latest version of the AWS Tools for PowerShell and Docker installed. For more information, see Getting Started with Amazon ECR .

### Use the following steps to authenticate and push an image to your repository. For additional registry authentication methods, including the Amazon ECR credential helper, see Registry Authentication .

### Step 1: Retrieve an authentication token and authenticate your Docker client to your registry.

#### Use AWS Tools for PowerShell:
```
(Get-ECRLoginCommand).Password | docker login --username AWS --password-stdin 561243041928.dkr.ecr.ap-south-1.amazonaws.com
```
### Step 2: Build your Docker image using the following command. For information on building a Docker file from scratch see the instructions here . You can skip this step if your image is already built:
```
docker build -t myapp .
```
### Step 3: After the build completes, tag your image so you can push the image to this repository:
```
docker tag myapp:latest 561243041928.dkr.ecr.ap-south-1.amazonaws.com/myapp:latest
```
### Step 4: Run the following command to push this image to your newly created AWS repository:
```
docker push 561243041928.dkr.ecr.ap-south-1.amazonaws.com/myapp:latest
```
***************************************************************
# To pull the image dev server

install docker


login to ecr epo
```
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 561243041928.dkr.ecr.ap-south-1.amazonaws.com
```
```
docker run -d -p 8080:8080 --name myapp 561243041928.dkr.ecr.ap-south-1.amazonaws.com/myapp:latest
```

13.233.186.198:8080/course-svc