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
//            parallel {
//                stage('Docker Build') {
//                    steps {
//                        script {
//                            dockerImage = docker.build("raymondmm/spring-boot-demo-blue-ocean:latest", ".")
//                        }
//
//                    }
//                }
//                stage('Test') {
                    agent {
                        dockerfile {
                            filename 'Dockerfile'
//                            args '-v /tmp:/tmp'
                        }
                    }
                    steps {
                        sh 'pwd'
                    }
//                }
//            }
        }
    }
}
