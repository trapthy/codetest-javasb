pipeline {
 agent any
 environment {
  AWS_ACCOUNT_ID="569306433961"
  AWS_DEFAULT_REGION="us-east-2"
  IMAGE_REPO_NAME="inseadecr"
  IMAGE_TAG="latest"
  REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"

 }
 
 tools {
        maven "maven"
    }
 stages {
   stage('Clone Repo') {
    steps{
     script{
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'dockerhub', url: 'https://github.com/trapthy/codetest-javasb.git']]])
    }   
   }
   }
 stage('Build Project') {
      steps{
      sh "mvn clean package"
      sh "chmod +x mvnw"
    }
 }
  stage('Scan') {
            steps { 
                    snykSecurity ( snykInstallation: 'snyk@latest', snykTokenId: 'snyk-api', failOnIssues: 'false')
          
            }   
        }

 stage('Building image') {
   steps{
     script {
        dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
     }
   }
 }
  
stage('Logging into AWS ECR') {
  steps {
    script {
       sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login  --username AWS  --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
}
  }
}
//  stage('Scan image') {
//     steps{
//        snykSecurity ( snykInstallation: 'snyk@latest', snykTokenId: 'snyk-api', failOnIssues: 'false',  targetFile: '/var/lib/jenkins/workspace/code-java/Dockerfile')
//  }
//  }
 stage('Push Image') {
    steps{
      script {
        sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"
        sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
 }
 }
 }
 }
 }

