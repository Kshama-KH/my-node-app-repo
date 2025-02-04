pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Kshama-KH/my-node-app-repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t kshamakh/my-node-app:latest .'
            }
        }

        stage('Authenticate Snyk') {
            steps {
                withCredentials([string(credentialsId: 'snyk-api-token', variable: 'SNYK_TOKEN')]) {
                    // Authenticate Snyk CLI with the token
                    sh 'C:/Users/Kshama/AppData/Roaming/npm/snyk auth $SNYK_TOKEN'
                }
            }
        }

        stage('Vulnerability Scanning with Snyk') {
            steps {
                script {
                    echo 'Running Snyk scan...'
                    sh 'C:/Users/Kshama/AppData/Roaming/npm/snyk container test kshamakh/my-node-app:latest'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh 'docker login -u $DOCKER_USER --password-stdin <<< "$DOCKER_PASS"'
                }
                sh 'docker push kshamakh/my-node-app:latest'
            }
        }
    }
}
