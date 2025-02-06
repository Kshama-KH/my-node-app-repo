pipeline {
    agent any  // Run on any available agent

    stages {
        // Step to checkout code from Git repository
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Kshama-KH/my-node-app-repo.git'
            }
        }

        // Step to build the Docker image
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t kshamakh/my-node-app:latest .'  // Ensure Dockerfile is in the root of your repo
            }
        }

        // Step to scan the Docker image for vulnerabilities using Trivy
        stage('Vulnerability Scanning with Trivy') {
            steps {
                script {
                    echo 'Running Trivy scan on the Docker image...'
                    def result = sh(script: 'trivy image --severity HIGH,CRITICAL kshamakh/my-node-app:latest', returnStatus: true)
                    if (result != 0) {
                        error 'Critical vulnerabilities found in the image during Trivy scan!'
                    }
                }
            }
        }

        // Step to scan the Docker image for vulnerabilities using Snyk
        stage('Vulnerability Scanning with Snyk') {
            steps {
                script {
                    echo 'Running Snyk scan on the Docker image...'
                    // Authenticate Snyk using an API token stored in Jenkins credentials
                    withCredentials([string(credentialsId: 'snyk-api-token', variable: 'SNYK_TOKEN')]) {
                        sh 'C:/Users/Kshama/AppData/Roaming/npm/snyk auth $SNYK_TOKEN'
                    }
                    // Run the Snyk container scan with a file reference to the Dockerfile for better accuracy
                    def snykResult = sh(script: 'C:/Users/Kshama/AppData/Roaming/npm/snyk container test kshamakh/my-node-app:latest --file=./Dockerfile', returnStatus: true)
                    if (snykResult != 0) {
                        echo 'Vulnerabilities found during Snyk scan. Review the results.'
                    }
                }
            }
        }

        // Step to push the Docker image to a Docker registry (like Docker Hub)
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
