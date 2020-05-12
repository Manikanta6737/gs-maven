pipeline {
    environment {
    PROJECT = "sequislife-pilot"
    APP_NAME = "sample-java"
    FE_SVC_NAME = "${APP_NAME}"
    CLUSTER = "jenkins-cicd"
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
  stage ('Remote SSH') {
            steps {
                script {
                    def remote = [:]
                    remote.name = 'infra-as-code'
                    remote.host = '10.0.0.7'
                    remote.user = 'jenkns'
                    remote.password = '$6$4Tm5Ebgl$1zffJZdXtC4uOAexNWR6CjWSjiNiRZqLSBm7yu6.gm0IvuULUQuUMjEAD9qa2VprIcxT1BfCfT.vKkgqUO98A1'
                    remote.allowAnyHosts = true

                    sshCommand remote: remote, command: "source ~/.bash_profile; cd /root/sequis-life/source/mpower-backend-premise/bin; ./bin/sidekiq_start.sh"
                }	
            }
    	}
    }
   } 
