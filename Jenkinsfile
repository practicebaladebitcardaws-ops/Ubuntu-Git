pipeline {
    agent any
    tools {
        maven 'maven'
        }
    environment {
        VENKAIAH_HOME = tool 'sonar-scanner'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'petclinic', url: 'https://github.com/practicebaladebitcardaws-ops/Ubuntu-Git.git'
            }
        }
        stage('Git Leaks') {
            steps {
                sh 'gitleaks detect --source . --exit-code 0'
            }
        }
        stage('Trivy File Scan') {
            steps {
                sh 'trivy fs --format table --output smaple-report.html .'
            }
        }
        stage ('Maven Build') {
            steps {
                
                sh 'mvn clean package'
            }
        }
                    
        stage('Sonar Qube Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh ''' $VENKIAH_HOME/bin/sonar-scanner -Dsonar.projectKey=petclinc -Dsonar.projectName=petcliic \
                            -Dsonar.java.binaries=target '''
                 }
            }
        }
        stage('Docker Build and Push') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'aditya-node') {
                            sh 'docker build -t venkaiahk/petclinic:v1 .'
                            sh 'docker push venkaiahk/petclinic:v1'
                        }
                }
            }
        }
        stage ('K8S Setup') {
            steps {
                
                sh 'kubectl apply -f k8s.yml'
            }
        }
    }
}
