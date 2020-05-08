
pipeline {
    environment {
    PROJECT = "sequislife-pilot"
    APP_NAME = "sample-java"
    FE_SVC_NAME = "${APP_NAME}"
    CLUSTER = "jenkins"
    CLUSTER_ZONE = "us-central1-c"
    IMAGE_TAG = "us.gcr.io/${PROJECT}/${APP_NAME}:latest"
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
    image: us.gcr.io/sequislife-pilot/maven
    command:
    - cat
    tty: true

  - name: gcloud
    image: us.gcr.io/sequislife-pilot/gcloud
    command:
    - cat
    tty: true
"""
}
  }
    tools {
    maven 'M3'
  }
    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
          }
        stage('Test') { 
            steps {
                sh 'mvn test' 
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml' 
                }
            }    
          }
        } 
}
