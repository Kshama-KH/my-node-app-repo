pipeline {
    agent any  // Run on any available agent

    stages {
        // Step to checkout code from Git repository
        stage('Checkout Code') {
            steps {
                // Checkout code from your repository, specifying the 'main' branch
                git branch: 'main', url: 'https://github.com/Kshama-KH/my-node-app-repo.git'
            }
        }

        // Step to build the Docker image
        stage('Build Docker Image') {
            steps {
                // Build Docker image using Dockerfile
                sh 'docker build -t kshamakh/my-node-app:latest .'  // Ensure Dockerfile is in the root of your repo
            }
        }

        // Step to scan the Docker image for vulnerabilities using Trivy
        stage('Vulnerability Scanning with Trivy') {
            steps {
                script {
                    echo 'Running Trivy scan on the Docker image...'
                    // Scan Docker image using Trivy
                    sh 'trivy image kshamakh/my-node-app:latest'
                }
            }
        }

        // Step to scan the Docker image for vulnerabilities using Snyk
        stage('Vulnerability Scanning with Snyk') {
            steps {
                script {
                    echo 'Running Snyk scan on the Docker image...'
                    // Scan Docker image using Snyk
                    sh 'snyk container test kshamakh/my-node-app:latest'
                }
            }
        }

        // Step to push the Docker image to a Docker registry (like Docker Hub)
        stage('Push Docker Image') {
            steps {
                // Authenticate with Docker Hub using Jenkins credentials
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh 'docker login -u $DOCKER_USER --password-stdin <<< "$DOCKER_PASS"'
                }

                // Push the built image to Docker Hub
                sh 'docker push kshamakh/my-node-app:latest'
            }
        }
    }
}
