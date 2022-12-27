pipeline {
 environment {
 imagename = “trapthyshetty/insead-demo”
 registryCredential = ‘dockerhub’
 dockerImage = ‘’
 def mvnHome = tool 'maven'
 }
 agent any
 stages {
 stage(‘Cloning Git’) {
 steps {
 git([url: 'https://github.com/trapthy/codetest-javasb.git', branch: ‘main’])
 }
  
 stage('Build Project') {
      // build project via maven
      sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
    }
 }
 stage(‘Building image’) {
 steps{
 script {
 dockerImage = docker.build imagename
 }
 }
 }
 stage(‘Running image’) {
 steps{
 script {
 sh “docker run ${imagename}:latest”
 }
 }
 }
 stage(‘Deploy Image’) {
 steps{
 script {
 docker.withRegistry( ‘’, registryCredential ) {
 dockerImage.push(“$BUILD_NUMBER”)
 dockerImage.push(‘latest’)
 }
 }
 }
 }
 }
}
