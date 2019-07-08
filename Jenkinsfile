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
        stage('Docker Build') {
          steps {
            script {
              dockerImage = docker.build("raymondmm/spring-boot-demo-blue-ocean:latest", ".")
            }

          }
        }
        stage('Test') {
          agent {
            // Equivalent to "docker build -f Dockerfile.build --build-arg version=1.0.2 ./build/
            dockerfile {
              filename 'Dockerfile'
//              dir 'build'
//              label 'my-defined-label'
//              additionalBuildArgs  '--build-arg version=1.0.2'
              args '-v /tmp:/tmp'
            }
          }
        }
      }
    }
  }
}
