#!groovy

@Library('github.com/ayudadigital/jenkins-pipeline-library@v6.3.0') _


///Initialize global config
cfg = jplConfig('reto', 'backend' ,'', [email: 'amelgar@mapfre.com'])
cfg.commitValidation.enabled = false


pipeline {
    
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    } 
    
    stages {
        stage ('Initialize') {
            steps  {
                jplStart(cfg)
        //        sh "ln -sf $PEM_FILE kevops-academy.pem"
                //sh "terraform init -backend-config=./web/"
                sh "terraform init -backend-config=./"
            }
        }
        stage ("Terraform init") {
            steps {
                sh "terraform init"
            }
        }
        stage ("Terraform plan") {
            when { not { branch 'main' } }
            steps {
                sh "terraform plan"
            }
        }
        stage ("Terraform apply") {
            when { branch 'main' }
            steps {
                sh """
                    terraform plan 
                    terraform apply --auto-approve
                """
            }
        }
        stage ("Terraform show") {
            steps {
                sh "terraform show"
            }
        }
    }

    post {
        always {
            jplPostBuild(cfg)
        }
    }

    options {
        timestamps()
        ansiColor('xterm')
        buildDiscarder(logRotator(artifactNumToKeepStr: '20',artifactDaysToKeepStr: '30'))
        disableConcurrentBuilds()
        timeout(time: 30, unit: 'MINUTES')
    }
}
