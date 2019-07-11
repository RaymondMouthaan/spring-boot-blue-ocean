pipeline {
    agent none
    environment {
        LIN_WORKSPACE = ""
    }

    stages {

        stage('Build') {
            agent {
                docker {
                    image 'maven:3.6.1-jdk-11-slim'
                    args '-v /Users/raymondmouthaan/.m2:/root/.m2'
                }
            }

            steps {
                script {
                    LIN_WORKSPACE = WORKSPACE
                }
                sh 'mvn clean package -U'
            }
        }

        stage('Docker Build') {
            parallel {
                stage('Docker Build amd64') {
                    agent {
                        docker {
                            image 'docker'
                        }
                    }
                    options { skipDefaultCheckout() }

                    steps {
                        dir(LIN_WORKSPACE) {
                            sh 'ls -al'
                            sh 'pwd'
                            script {
                                dockerImageAmd64 = docker.build("raymondmm/spring-boot-demo-blue-ocean:amd64", "-f Dockerfile.amd64 .")
                            }
                        }
                    }
                }
                stage('Docker Build arm32v7') {
                    agent {
                        docker {
                            image 'docker'
                            reuseNode true
                        }
                    }
                    options { skipDefaultCheckout() }

                    steps {
                        dir(LIN_WORKSPACE) {
                            sh 'ls -al'
                            sh 'pwd'
                            script {
                                dockerImageArm32v7 = docker.build("raymondmm/spring-boot-demo-blue-ocean:arm32v7", "-f Dockerfile.arm32v7 .")
                            }
                        }
                    }
                }
            }
        }
        stage('Docker Image') {
            parallel {
                stage('Docker Image amd64') {
                    steps {
                        script {
                            dockerContainerAmd64 = dockerImageAmd64.run("-p8888:8080 --name spring-boot-demo-app-amd64 -e TZ=Europe/Amsterdam")
                        }

                    }
                }
                stage('Docker Image arm32v7') {
                    steps {
                        script {
                            dockerContainerArm32v7 = dockerImageArm32v7.run("-p8899:8080 --name spring-boot-demo-app-arm32v7 -e TZ=Europe/Amsterdam")
                        }

                    }
                }
            }
        }
        stage('Docker Manifest') {
            steps {
                sh 'mkdir -p $HOME/.docker'
                sh 'echo \'{"experimental": "enabled"}\' | tee $HOME/.docker/config.json'
                sh 'docker manifest --help'
                sh 'docker ps -a'
            }
        }
        stage('A') {
            parallel {
                stage('A') {
                    steps {
                        sh 'echo A'
                    }
                }
                stage('B') {
                    steps {
                        sh 'echo B'
                    }
                }
                stage('C') {
                    steps {
                        sh 'echo C'
                    }
                }
            }
        }
        stage('A1') {
            parallel {
                stage('A1') {
                    steps {
                        sh 'echo A1'
                    }
                }
                stage('B1') {
                    steps {
                        sh 'echo B1'
                    }
                }
                stage('C1') {
                    steps {
                        sh 'echo C1'
                    }
                }
            }
        }
    }
    post {
        always {
            echo 'Stop Docker image'
            script {
                if (dockerContainerAmd64) {
                    dockerContainerAmd64.stop()
                }
                if (dockerContainerArm32v7) {
                    dockerContainerArm32v7.stop()
                }
            }


        }

    }
}

