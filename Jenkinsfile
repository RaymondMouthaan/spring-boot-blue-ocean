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
                            dockerImageTest = docker.build("raymondmm/spring-boot-demo-blue-ocean:latest", ".")
                        }

                    }
                }
                stage('Docker Build latest') {
                    steps {
                        script {
                            dockerImageLatest = docker.build("raymondmm/spring-boot-demo-blue-ocean:latest", ".")
                        }
                    }
                }
            }
            stage('Docker Run') {
                steps {
                    script {
                        dockerContainer = dockerImageLatest.run("-p8888:8080 --name spring-boot-demo-app-testing -e TZ=Europe/Amsterdam")
                    }
                }
            }
        }
    }
}
