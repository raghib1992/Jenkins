pipeline {
    agent any
   
    environment {
        PASS = credentials('docker-password')
        SSH_KEY = credentials(raghib-key.pem)
    }
    stages {
        stage('Build') { 
            steps {
                sh '''
                    ./maven-example/build/mvn.sh mvn -B -DskipTests clean package
                    ./maven-example/build/build.sh
                '''
            }
        }
        stage('Test') { 
            steps {
                sh './maven-example/test/mvn.sh mvn test'
            }
        }
        stage('Test') {
            steps {
               sh './maven-example/push/push.sh'
            }
        }
        stage('Deploy') { 
            steps {
                sh './maven-exapmle/deploy/deploy.sh'
            }
        }
    }
}
