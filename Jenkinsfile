pipeline {
    agent any
    tools {
        nodejs 'node21'
        jdk 'java17installation'
    }
    environment {
        SONAR_SCANNER= tool 'sonar-scanner'
    }
    stages {
        stage('Git Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/aditya-node']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/practicebaladebitcardaws-ops/Ubuntu-Git.git']])
            }
        }
        
        stage('Installing Dependencies and Building the Node app') {
            steps {
                sh ' npm install'
                sh 'npm run build'
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                        sh ''' $SONAR_SCANNER/bin/sonar scanner -Dsonar.projectKey=aditya-node -Dsonar.project.Name=aditya-node'''
                }
            }
        }
        
        stage('Docker Image Buiding and Pusing') {
            steps {
                script {
                    withDockerRegistry(credentialsId: '762b8c50-32c1-486f-ac0f-b7ef2f981985', url: 'https://hub.docker.com/') {
                            sh 'docker build -t venkaiahk/aditya-nodeapp:v1 .'
                            sh 'docker run --name=nodeapp -dt -p 5600:3000 aditya-nodeapp:v1'
                            sh 'docker push venkaiahk/aditya-nodeapp:v1'
                        }
                }
            }
        }
    }
}
