pipeline {
    agent {
        docker {
            image 'maven:3.6.1-jdk-11-slim'
            args '-v /Users/raymondmouthaan/.m2:/root/.m2'
        }

    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package -U'
            }
        }
        stage('Docker Build') {
            parallel {
                stage('Docker Build Test') {
                    steps {
                        script {
                            dockerImageTest = docker.build("raymondmm/spring-boot-demo-blue-ocean:test", ".")
                        }

                    }
                }
                stage('Docker Build Latest') {
                    steps {
                        script {
                            dockerImageLatest = docker.build("raymondmm/spring-boot-demo-blue-ocean:latest", ".")
                        }

                    }
                }
            }
        }
        stage('Docker Image') {
            parallel {
                stage('Docker Image Test') {
                    steps {
                        script {
                            dockerContainerTest = dockerImageTest.run("-p8888:8080 --name spring-boot-demo-app-test -e TZ=Europe/Amsterdam")
                        }

                    }
                }
                stage('Docker Image Latest') {
                    steps {
                        script {
                            dockerContainerLatest = dockerImageLatest.run("-p8899:8080 --name spring-boot-demo-app-latest -e TZ=Europe/Amsterdam")
                        }

                    }
                }
            }
        }

    }

    post {
        always {
            echo "Stop Docker image"
            script {
                if (dockerContainerTest) {
                    dockerContainerTest.stop()
                }
                if (dockerContainerLatest) {
                    dockerContainerLatest.stop()
                }
            }
        }
    }
}
