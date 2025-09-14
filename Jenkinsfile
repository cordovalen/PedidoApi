pipeline {
    agent any

    environment {
        // Nombre del repositorio de tu imagen de Docker Hub
        DOCKER_IMAGE_NAME = 'cordovale/pedidoapi'
        // Credenciales de Docker Hub configuradas en Jenkins
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
    }

    stages {
        stage('Restore and Build') {
            steps {
                dir('PedidoApi') {
                    sh 'dotnet restore'
                    sh 'dotnet build'
                    sh 'dotnet test'
                    sh 'dotnet publish -c Release -o out'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def imageTag = "${env.BUILD_NUMBER}"
                    dir('PedidoApi') {
                        sh "docker build -t ${DOCKER_IMAGE_NAME}:${imageTag} -f .docker/Dockerfile ."
                    }
                }
            }
        }

        stage('Push Docker Image to Hub') {
            steps {
                script {
                    def imageTag = "${env.BUILD_NUMBER}"
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                        sh "docker push ${DOCKER_IMAGE_NAME}:${imageTag}"
                    }
                }
            }
        }

        stage('Update Helm Chart values.yaml') {
            steps {
                script {
                    def imageTag = "${env.BUILD_NUMBER}"
                    sh "sed -i '' 's|tag: .*|tag: ${imageTag}|' charts/pedido-app/values.yaml"
                }
            }
        }

        stage('Commit and Push Changes') {
            steps {
                script {
                    sh "git config user.email 'jenkins@your-company.com'"
                    sh "git config user.name 'Jenkins CI'"
                    sh "git add charts/pedido-app/values.yaml"
                    sh "git commit -m '[CI] Update Helm chart image tag to ${env.BUILD_NUMBER}'"
                    sh "git push origin HEAD:main"
                }
            }
        }
    }
}