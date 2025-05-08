pipeline {
    agent any

    environment {
        IMAGE_NAME = "gopu1234/note-apk"
        IMAGE_TAG = "latest"
        KUBECONFIG = '/var/lib/jenkins/.kube/config'

    }

    stages {
        stage("Clone Git Code") {
            steps {
                git url: "https://github.com/gopu2311/todo-app.git" , branch: "main"
            }
        }

        stage("Build Docker Image") {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }
        stage ("Push Docker iamge"){
            steps{
                 withDockerRegistry([credentialsId: 'dockerhub-creds', url: '']) {
                     sh "docker push ${IMAGE_NAME}:latest"
                 }
            }
        }
        stage("Buid app by ks8"){
            steps{
                sh "kubectl apply -f k8s/deployment.yaml "
                sh "kubectl apply -f k8s/service.yaml "
            }
        }
    }
}
