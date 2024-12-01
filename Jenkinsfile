pipeline {
        agent any
        environment {
                GIT_REPOSITORY_URL = 'https://github.com/blackopsGun/python_CICD.git'
                DOCKER_IMAGE_NAME = 'blackopsgun/ks_python'
                IMAGE_TAG = '5.0'
        }
        stages {
                stage('Clone Repository') {
                        steps {
                                script {
                                        try {
                                                git branch: 'main', url: GIT_REPOSITORY_URL
                                        } catch (Exception e) {
                                                echo "Failed to clone repository: ${e.message}"
                                                error "Failed to clone repository"
                                        }
                                }
                        }
                }
                stage('Build Docker Image') {
                        steps {
                                script {
                                        try {
                                                docker.build("${DOCKER_IMAGE_NAME}:${IMAGE_TAG}")
                                        } catch (Exception e) {
                                                echo "Failed to build Docker image"
                                        }
                                }
                        }
                }

                stage('Push to DockerHub') {
                        steps {
                                script {
                                        try {
                                                withCredentials([usernamePassword(credentialsId: 'my-docker-hub-credentials-id', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                                                //Explicit login before push
                                                sh """
                                                echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                                                docker push ${DOCKER_IMAGE_NAME}:${IMAGE_TAG}
                                                """
                                                }
                                        } catch (Exception e) {
                                                echo "Failed to push Docker Image to registry: ${e.message}"
                                                error "Failed to push Docker image"
                                        }
                                }
                        }
                }

                stage('Deploy To Kubernetes') {
                        steps {
                                script {
					sh 'sudo apt-get update'
					sh 'apt-get install -y kubectl'
		                        sh 'kubectl apply -f deployment.yml'

					}
				}
		}

        }

}
