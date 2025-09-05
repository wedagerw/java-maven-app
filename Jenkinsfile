pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'wedagerw/java-maven-app:latest'
        DOCKER_CREDS = 'docker-jenkins-creds'
    }
    stages {
        stage('Build') {
            steps {
                bat 'mvn clean package'
                bat "docker build -t java-maven-app ."
                bat "docker tag java-maven-app %DOCKER_IMAGE%"
            }
        }
        stage('Test') {
            steps {
                bat "docker run java-maven-app java -jar target/demo-1.0.0.jar"
            }
        }
        stage('Deploy') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKER_CREDS}",
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    bat "echo %DOCKER_PASSWORD% | docker login -u %DOCKER_USERNAME% --password-stdin"
                    bat "docker push %DOCKER_IMAGE%"
                }
            }
        }
    }
    post {
        always {
            bat "docker logout"
        }
    }
}
