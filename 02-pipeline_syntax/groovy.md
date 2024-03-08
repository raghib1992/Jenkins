### define groovy script
#### file name: script.groovy
```groovy
def deployApp() {
    echo "deploy stage"
    echo "deploying version ${param.VERSION}"  //all param is aslo accessable here
}

def buildApp() {
    echo 'building the application...'
}

return this
```
### Load this groovy script in Jenkinsfile
```t
def gv

pipeline{
    agent any
    parameters {
        string(name: 'VERSION', defaultValue: '', description: 'version to deploy on prod')
        chioce(name: 'VERSION', choices: ['1.1.0', '1.2.0', '1.3.0'], description: '')
        booleanParam(name: 'executeTest', defaultValue: true, description: 'version to deploy on prod')
    }
    stages {
        stage('init'){
            steps {
                script {
                    gv = load "script.groovy"
                }
            }
        }
        stage('build'){
            steps {
                script{
                    gv.buildApp()
                }
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
                script {
                    gv.deployApp()
                }
            }
        }
    }
}
```
