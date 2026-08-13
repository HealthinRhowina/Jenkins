pipeline {

    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Maven Build') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Docker Build') {
            steps {
                bat 'docker build -t myapp:1.0 .'
            }
        }

        stage('Docker Deploy') {
            steps {
                bat '''
                docker rm -f myapp-container 2>nul || exit /b 0
                docker run -d --name myapp-container -p 8081:8080 myapp:1.0
                '''
            }
        }

        stage('Check Container') {
            steps {
                bat 'docker ps'
                bat 'docker logs myapp-container'
            }
        }
    }

    post {
        success {
            echo '======================================'
            echo 'DEPLOYMENT SUCCESSFUL'
            echo 'Application: http://localhost:8081'
            echo '======================================'
        }

        failure {
            echo '======================================'
            echo 'DEPLOYMENT FAILED'
            echo '======================================'
        }
    }
}