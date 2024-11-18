pipeline {
    agent any

    environment {
        AZURE_VM_IP = '40.91.217.138'
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
            // Build the Docker image, specifying the path to Dockerfile
            sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
        }
    }
}
        
     stage('Save Docker Image') {
        steps {
            sh 'docker save -o express-app.tar express-app:latest'
    }
}  
        
     stage('Copy to Azure VM') {
        steps {
            sshagent(credentials: ["${SSH_CREDENTIALS_ID}"]) {
                sh '''
                scp express-app.tar MP20040674@40.91.217.138:/tmp/
                '''
        }
    }
}
   
     stage('Deploy to Azure VM') {
        steps {
            script {
                    // Use SSH to connect to the Azure VM and run Docker commands to pull and run the container
                 sshagent(credentials: ["${SSH_CREDENTIALS_ID}"]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no MP20040674@${AZURE_VM_IP} << EOF
                    docker load < /tmp/express-app.tar
                    docker run -d --name express-app-container -p 80:3000 express-app:latest
                    EOF
                    '''
        }
    }
}
            
