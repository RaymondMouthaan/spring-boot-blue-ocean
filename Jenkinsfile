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
      agent { dockerfile true }
      steps {
        script {
          // Build image with Jenkins' docker-plugin
          withDockerServer([uri: "tcp://denpasar.indonesia:2575"]) {
            dockerImage = docker.build("raymondmm/spring-boot-demo-blue-ocean:latest", ".")
          }
        }

      }
    }
  }
}
