pipeline {
    agent any

    environment {
        AZURE_VM_IP = '13.95.119.149'
        SSH_CREDENTIALS_ID = 'ServerClient'  // The ID of the SSH credential you created
        DOCKER_IMAGE = 'express-app'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the Git repository
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                }
            }
        }
        
        //stage('Push Docker Image to Registry') {
            //steps {
                // Push Docker image to a registry, if using Docker Hub or a private registry
               // sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                
               // echo 'Docker image push step (uncomment if needed for your registry)'
           // }
        //}//

        stage('Deploy to Azure VM') {
            steps {
                script {
                    // Use SSH to connect to the Azure VM and run Docker commands to pull and run the container
                    sshagent(credentials: ["${SSH_CREDENTIALS_ID}"]) {
                        sh """
                        ssh -o StrictHostKeyChecking=no MP20040674@${AZURE_VM_IP} << EOF
                        docker pull ${DOCKER_IMAGE}:${DOCKER_TAG} || true
                        docker stop express-app || true
                        docker rm express-app || true
                        docker run -d --express-app -p 3000:3000 ${DOCKER_IMAGE}:${DOCKER_TAG}
                        EOF
                        """
                    }
                }
            }
        }
    }
}
