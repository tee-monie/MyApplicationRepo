pipeline {

    agent any

    tools {
         maven "Maven3"
    }

    stages {
        
        stage("Chechkout") {
            steps {
            checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '1ecc9021-04dc-458d-824b-e2a4314512c1', url: 'https://github.com/tee-monie/MyApplicationRepo']])
            }
        }
        
        stage ("Build") {
            steps {
                sh 'mvn clean install -f MyWebApp/pom.xml'
            }
        }
        
         stage ('Code Quality') {
            steps {
                withSonarQubeEnv('SonarQube') {
                sh 'mvn sonar:sonar -f MyWebApp/pom.xml'
                }
            }
        }
        
        stage ('Nexus Upload') {
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'MyWebApp', classifier: '', file: 'MyWebApp/target/MyWebApp.war', type: 'war']], credentialsId: '27f682d6-024e-4544-9311-ae62b8efe81e', groupId: 'com.dept.app', nexusUrl: 'ec2-100-25-134-215.compute-1.amazonaws.com:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'maven-snapshots', version: '1.0-SNAPSHOT'
            }
        }
        
        stage ('Dev Deploy') {
            steps {
                deploy adapters: [tomcat9(credentialsId: 'e0606e7e-5abb-4f3e-8ef9-b5906edda676', path: '', url: 'http://ec2-44-212-1-34.compute-1.amazonaws.com:8080')], contextPath: null, war: '**/*.war'
            }
        }
        
        stage ('Slack Notify') {
            steps {
                slackSend channel: 'sept-online-batch', message: 'Dev deployment was successful'
            }
        }
        
        stage ('Dev approval') {
            steps {
                echo "Taking approval from Dev Manager for QA Deployment"
                timeout(time: 7, unit: 'DAYS') {
                input message: 'Do you want to deploy into QA?', submitter: 'admin'
                }
            } 
        }
        
        stage ('QA Deploy') {
            steps {
                deploy adapters: [tomcat9(credentialsId: 'e0606e7e-5abb-4f3e-8ef9-b5906edda676', path: '', url: 'http://ec2-44-212-1-34.compute-1.amazonaws.com:8080')], contextPath: null, war: '**/*.war'
            }
        }
        
        stage ('Slack Notify-QA') {
            steps {
                slackSend channel: 'sept-online-batch', message: 'Dev Deployment was successful, please start your testing'
            }
        }
    }
    
}
