pipeline {
    agent any
    tools {
        maven 'maven'
    }
    environment {
        SONAR_SCANNER_HOME = tool 'sonar-scanner'
        IMAGE_NAME = 'venkaiahk/task:v1'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'testmaker', url: 'https://github.com/practicebaladebitcardaws-ops/Ubuntu-Git.git'
            }
        }
        stage('Git Leaks check') {
            steps {
                sh 'gitleaks detect --source .'
            }
        }
        stage('Trivy File Scan') {
            steps {
                sh 'trivy fs --format table --output sample-report.html .'
            }
        }
        stage('Building and packaging the application') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh ''' $SONAR_SCANNER_HOME/bin/sonar-scanner -Dsonar.projectKey=test \
                    -Dsonar.java.binaries=target'''
            }
        }
        }
        
        stage('Building Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'aditya-node') {
                            sh 'docker build -t ${IMAGE_NAME} .'
                            sh 'trivy image ${IMAGE_NAME} '
                            sh 'docker push ${IMAGE_NAME}'
                            
                        }
                }
            }
        }
        stage('K8S Deployment') {
            steps {
                sh 'kubectl create -f k8s.yml'
            }
        }
    }
}

