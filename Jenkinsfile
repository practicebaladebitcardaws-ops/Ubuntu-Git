pipeline {
    agent any
    tools {
        nodejs 'node21'
        
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
                        sh ''' $SONAR_SCANNER/bin/sonar-scanner -Dsonar.projectKey=aditya-node -Dsonar.project.Name=aditya-node -Dsonar.java.binaries=build'''
                }
            }
        }
        
        stage('Docker Image Buiding and Pusing') {
            steps {
                script {
                            sh 'docker build -t venkaiahk/aditya-nodeapp:v2 .'
                            sh 'docker run --name=nodeappp -dt -p 5700:3000 venkaiahk/aditya-nodeapp:v2'
                        
                }
            }
        }
    }
}
