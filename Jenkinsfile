pipeline {
 environment {
 imagename = "trapthyshetty/insead-demo"
 registryCredential = 'dockerhub'
 dockerImage = ''

 }
 agent any
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
        dockerImage = docker.build imagename
     }
   }
 }
 stage('Scan image') {
    steps{
       snykSecurity ( snykInstallation: 'snyk@latest', snykTokenId: 'snyk-api', failOnIssues: 'false',  targetFile: '/var/lib/jenkins/workspace/code-java/Dockerfile')
 }
 }
 stage('Push Image') {
    steps{
      script {
        docker.withRegistry( '', registryCredential ) {
        dockerImage.push("$BUILD_NUMBER")
        dockerImage.push('latest')
 }
 }
 }
 }
 }
}
