
pipeline {
    environment {
    PROJECT = "sequislife-pilot"
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
    image: us.gcr.io/sequislife-pilot/maven
    command:
    - cat
    tty: true

  - name: helm
    image: us.gcr.io/sequislife-pilot/helm3
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
                sh """
	           #mvn -B -DskipTests clean package
		   """
	}
    }
  stage ('Deploy Web') {
            steps {
                script {
                    def remote = [:]
                    remote.name = 'Staging Gateway'
                    remote.host = '172.16.250.80'
                    remote.user = 'inovlab'
                    remote.password = 'Abcd1234!'
                    remote.allowAnyHosts = true

                    sshCommand remote: remote, command: "source ~/.bash_profile; cd /home/inovlab/web/mpower-backend-premise; ./bin/web_start.sh ${tag_response}"
                }
            }
        }
       }
     } 
