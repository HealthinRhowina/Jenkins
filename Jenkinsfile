pipeline {

    agent any

    environment {
        DOCKER_PATH = 'C:\\Users\\hrhow\\AppData\\Local\\Programs\\DockerDesktop\\resources\\bin'
        PATH = "${DOCKER_PATH};${env.PATH}"
    }

    stages {

        stage('Check Tools') {
            steps {
                bat 'java -version'
                bat 'mvn -version'
                bat 'where docker'
                bat 'docker --version'
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

        stage('Check Deployment') {
            steps {
                bat 'docker ps'
                bat 'docker logs myapp-container'
            }
        }
    }

    post {
        success {
            echo 'DEPLOYMENT SUCCESSFUL'
            echo 'Application: http://localhost:8081'
        }

        failure {
            echo 'DEPLOYMENT FAILED'
        }
    }
}