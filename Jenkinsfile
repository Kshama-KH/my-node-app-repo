pipeline {
    agent any  // Run on any available agent

    stages {
        // Step to checkout code from Git repository
        stage('Checkout Code') {
            steps {
                // Checkout code from your repository
                git 'https://github.com/Kshama-KH/my-node-app-repo.git'
            }
        }

        // Step to build the Docker image
        stage('Build Docker Image') {
            steps {
                // Build Docker image using Dockerfile
                sh 'docker build -t my-node-app:latest .'  // Ensure Dockerfile is in the root of your repo
            }
        }

        // Step to push the Docker image to a Docker registry (like Docker Hub)
        stage('Push Docker Image') {
            steps {
                // Authenticate with Docker registry (e.g., Docker Hub)
                sh 'docker login -u <username> -p <password>'

                // Tag and push the built image to Docker Hub
                sh 'docker tag my-node-app:latest your-docker-repo/my-node-app:latest'
                sh 'docker push your-docker-repo/my-node-app:latest'
            }
        }
    }
}
