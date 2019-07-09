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
    stage('Docker Build Test') {
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
  }
}