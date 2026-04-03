pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "sentry1904/flask-app"
        DOCKER_TAG = "latest"
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'git@github.com:sentry1904/newdir.git',
                    credentialsId: 'newdirkey'   // <-- use your private key credential ID here
            }
        }

        stage('Run App Locally') {
            steps {
                script {
                    // Run briefly to check it starts
                    sh "python3 newapp.py & sleep 5 && pkill -f newapp.py"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh "echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin"
                sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
            }
        }

        stage('Pull and Run from Docker Hub') {
            steps {
                sh "docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}"
                sh "docker rm -f flask-app || true"
                sh "docker run -d -p 5000:5000 --name flask-app ${DOCKER_IMAGE}:${DOCKER_TAG}"
            }
        }
    }

    post {
        always {
            echo "Pipeline finished!"
        }
    }
}

