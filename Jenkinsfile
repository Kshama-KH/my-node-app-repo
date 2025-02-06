pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout code from the GitHub repository
                git branch: 'main', url: 'https://github.com/Kshama-KH/my-node-app-repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image using the Dockerfile in the repository
                sh 'docker build -t kshamakh/my-node-app:latest .'
            }
        }

        stage('Authenticate Snyk') {
            steps {
                // Authenticate the Snyk CLI using API token stored in Jenkins credentials
                withCredentials([string(credentialsId: 'snyk-api-token', variable: 'SNYK_TOKEN')]) {
                    sh 'snyk auth $SNYK_TOKEN'
                }
            }
        }

        stage('Vulnerability Scanning with Snyk') {
            steps {
                script {
                    echo 'Running Snyk vulnerability scan on the Docker image...'
                    sh 'snyk container test kshamakh/my-node-app:latest'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                // Authenticate with Docker Hub and push the Docker image
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push kshamakh/my-node-app:latest
                    '''
                }
            }
        }
    }
}
