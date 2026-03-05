pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'python_app', url: 'https://github.com/practicebaladebitcardaws-ops/Ubuntu-Git.git'
            }
        }
        stage('Building Docker File') {
            steps {
                sh 'docker build -t venkaiahk/cicd-python-login:v1 .'
                script {
                    withCredentials([string(credentialsId: 'cd398dc0-ea30-48e3-a5ad-47e972b9a708', variable: 'pwdd')]) {
                        sh 'docker login -u venkaiahk -p ${pwdd}'
                        sh 'docker push venkaiahk/cicd-python-login:v1'
                        sh 'docker rmi venkaiahk/cicd-python-login:v1'
                    }
                }
                }
        }
        stage('Container creating') {
            steps {
                sh 'docker run -dt -P venkaiahk/cicd-python-login:v1'
            }
        }
    }
}
