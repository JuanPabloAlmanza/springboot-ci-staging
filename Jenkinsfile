pipeline {
    agent any
    environment {
        STAGING_SERVER = 'jhon@spring-docker-demo'
        ARTIFACT_NAME = 'demo-0.0.1-SNAPSHOT.jar'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/JuanPabloAlmanza/springboot-ci-staging.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Code Quality') {
            steps {
                // sh 'mvn checkstyle:check'
                echo 'turbo'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Code Coverage') {
            steps {
                sh 'mvn jacoco:report'
            }
        }
        stage('Deploy to Staging') {
            steps {
                sshagent(['ssh-turbo']) {
                    // sh 'scp target/${ARTIFACT_NAME} $STAGING_SERVER:/home/jhon/staging/'
                    sh 'scp -o StrictHostKeyChecking=no target/demo-0.0.1-SNAPSHOT.jar jhon@spring-docker-demo:/home/jhon/staging/'
                    sh 'ssh $STAGING_SERVER "nohup java -jar /home/jhon/staging/${ARTIFACT_NAME} > /dev/null 2>&1 &"'
                }
            }
        }
        stage('Validate Deployment') {
            steps {
                sh 'sleep 30'                
                    sh 'curl --fail http://localhost:8080/health'                
            }
        }
    }
}
