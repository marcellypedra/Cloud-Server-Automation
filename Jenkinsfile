pipeline {
    agent any

    environment {
        AZURE_VM_IP = '13.93.64.143'
        SSH_CREDENTIALS_ID = 'ServerClient'  // The ID of the SSH credential you created
        DOCKER_IMAGE = 'express-app'
        DOCKER_TAG = 'latest'
        AZURE_USER = 'MP20040674'  // Define username as an environment variable
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the Git repository
                checkout scm
            }
        }

        stage('Run ansible.sh') {  // New stage for running ansible.sh
            steps {
                script {
                    sh '''
                    chmod +x ./ansible.sh
                    bash ./ansible.sh
                    '''
                }
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
                sh "docker save -o ${DOCKER_IMAGE}.tar ${DOCKER_IMAGE}:${DOCKER_TAG}"
            }
        }

        stage('Copy to Azure VM') {
            steps {
                sshagent(credentials: ["${SSH_CREDENTIALS_ID}"]) {
                    sh """
                    scp ${DOCKER_IMAGE}.tar ${AZURE_USER}@${AZURE_VM_IP}:/tmp/
                    """
                }
            }
        }

        stage('Deploy to Azure VM') {
            steps {
                sshagent(credentials: ["${SSH_CREDENTIALS_ID}"]) {
                    script {
                        try {
                            sh """
                            ssh ${AZURE_USER}@${AZURE_VM_IP} << 'EOF'
                            docker load < /tmp/${DOCKER_IMAGE}.tar
                            docker run -d --name express-app-container -p 80:3000 ${DOCKER_IMAGE}:${DOCKER_TAG}
                            EOF
                            """
                        } catch (Exception e) {
                            echo "Ignoring non-critical error: ${e.getMessage()}"
                        }
                    }
                }
            }
        }
    }
}
