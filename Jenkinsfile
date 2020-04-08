
pipeline {
    environment {
    PROJECT = "pro1-265115"
    APP_NAME = "sample-java"
    FE_SVC_NAME = "${APP_NAME}"
    CLUSTER = "jenkins"
    CLUSTER_ZONE = "us-central1-c"
    IMAGE_TAG = "gcr.io/${PROJECT}/${APP_NAME}:latest"
    JENKINS_CRED = "${PROJECT}"
  }

  agent {
    kubernetes {
      label 'maven'
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
labels:
  component: ci
spec:
  # Use service account that can deploy to all namespaces
  
  containers:
  - name: maven
    image: us.gcr.io/pro1-265115/maven
    command:
    - cat
    tty: true

  - name: helm
    image: us.gcr.io/pro1-265115/helm3
    command:
    - cat
    tty: true
"""
}
  }
    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
      }
    }
  } 
