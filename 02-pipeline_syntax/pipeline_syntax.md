## Ppeline Syntax
### Scripted
- first syntax
- groovy engine
```
node {
    stage{

    }
    stage {

    }
}
```
### Declarative 
```
CODE_CHANGES = getGitChanges() //this is groovy script which check any change made in git or not
pipeline{
    agent any
    stages {
        stage('build'){
            when {
                expression {
                    //env.BRANCH_NAME = 'dev'
                    BRANCH_NAME = 'dev' && CODE_CHANGES == true
                }
            }
            steps {
                echo "build stage"
            }
        }
        stage('test'){
            when {
                expression {
                    //env.BRANCH_NAME = 'dev'
                    BRANCH_NAME = 'dev'
                }
            }
            steps {
                echo "test stage"
            }
        }
        stage('deploy'){
            steps {
                echo "deploy stage"
            }
        }
    }
    post {
        always{
            // sending mail to team
        }
        success{
            // run when pipeline is success
        }
        failure{
            // run when pipeline is fail
        }
    }
}
```
## Enviornmental Variable



#### Define own env variable in jenkinsfile
```
CODE_CHANGES = getGitChanges() //this is groovy script which check any change made in git or not
pipeline{
    agent any
    environment {
        NEW_VERSON = '1.3.0'
    }
    stages {
        stage('build'){
            when {
                expression {
                    //env.BRANCH_NAME = 'dev'
                    BRANCH_NAME = 'dev' && CODE_CHANGES == true
                }
            }
            steps {
                echo "build stage"
                echo "building version ${NEW_VERSION}
            }
        }
        stage('test'){
            when {
                expression {
                    //env.BRANCH_NAME = 'dev'
                    BRANCH_NAME = 'dev'
                }
            }
            steps {
                echo "test stage"
            }
        }
        stage('deploy'){
            steps {
                echo "deploy stage"
            }
        }
    }
    post {
        always{
            // sending mail to team
        }
        success{
            // run when pipeline is success
        }
        failure{
            // run when pipeline is fail
        }
    }
}
```

## Credentials
1. Define Credentials in Jenkins GUI
2. "credentials("credentialld") binds the credentials to your env variable
3. For that you need "Credentials Binding" Plugin
```
CODE_CHANGES = getGitChanges() //this is groovy script which check any change made in git or not
pipeline{
    agent any
    environment {
        NEW_VERSON = '1.3.0'
        SERVER_CREDENTIALS = credentials('server-credentials')
    }
    stages {
        stage('build'){
            when {
                expression {
                    //env.BRANCH_NAME = 'dev'
                    BRANCH_NAME = 'dev' && CODE_CHANGES == true
                }
            }
            steps {
                echo "build stage"
                echo "building version ${NEW_VERSION}
            }
        }
        stage('test'){
            when {
                expression {
                    //env.BRANCH_NAME = 'dev'
                    BRANCH_NAME = 'dev'
                }
            }
            steps {
                echo "test stage"
            }
        }
        stage('deploy'){
            steps {
                echo "deploy stage"
                withCredentials([
                    usernamePassword(credentials: 'server-credentials', usernameVariable: USER, usernameVariable: PWD)
                ]){
                    sh "some scrip ${USER} ${PWD}"
                }
            }
        }
    }
    post {
        always{
            // sending mail to team
        }
        success{
            // run when pipeline is success
        }
        failure{
            // run when pipeline is fail
        }
    }
}
```

## tools
```
pipeline{
    agent any
    tools {
        maven 'Maven'
        gradle 'Gradle_v_xxx'
    }
    stages {
        stage('build'){
            steps {
                echo "build stage"
                sh 'mvn build' 
            }
        }
        stage('test'){
            when {
                expression {
                    //env.BRANCH_NAME = 'dev'
                    BRANCH_NAME = 'dev'
                }
            }
            steps {
                echo "test stage"
            }
        }
        stage('deploy'){
            steps {
                echo "deploy stage"
            }
        }
    }
}
```

## Parameter 
```
pipeline{
    agent any
    parameters {
        string(name: 'VERSION', defaultValue: '', description: 'version to deploy on prod')
        chioce(name: 'VERSION', choices: ['1.1.0', '1.2.0', '1.3.0'], description: '')
        booleanParam(name: 'executeTest', defaultValue: true, description: 'version to deploy on prod')
    }
    stages {
        stage('build'){
            steps {
                echo "build stage"
            }
        }
        stage('test'){
            when {
                expresion {
                    param.executeTest == true
                }
            }
            steps {
                echo "test stage"
            }
        }
        stage('deploy'){
            steps {
                echo "deploy stage"
                echo "deploying version ${param.VERSION}"
            }
        }
    }
}
```