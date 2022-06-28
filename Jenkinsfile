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
        //stage ('Initialize') {
        //    steps  {
        //        jplStart(cfg)
        //        sh "ln -sf $PEM_FILE kevops-academy.pem"
                //sh "terraform init -backend-config=./web/"
        //        sh "terraform init -backend-config=./"
        //    }
        //}
        stage ("Terraform init") {
            steps {
                //sh "terraform init -reconfigure -force-copy"
                sh "terraform init"
            }
        }
        stage ("Sonar: escaneo ramas NO PR") {
            when { not { branch 'PR-*' } }
            steps {
        // Realiza analisis de la rama y lo manda a SonarCloud
                withSonarQubeEnv ('amelgarsonar') {
                    sh '~/.sonar/sonar-scanner-4.7.0.2747-linux/bin/sonar-scanner \
                        -Dsonar.organization=gransapote \
                        -Dsonar.projectKey=gransapote_Lab \
			-Dsonar.sources=. \
			-Dsonar.host.url=https://sonarcloud.io \
                        -Dsonar.branch.name="$BRANCH_NAME"'
                }
            }
        }
        stage ("Sonar: Escaneo de ramas en PR") {
            when { branch 'PR-*' }
            steps {
        // Realiza analisys en PR con SonarScanner y lo manda a SonarCloud
                withSonarQubeEnv ('amelgarsonar') {
                    sh "~/.sonar/sonar-scanner-4.7.0.2747-linux/bin/sonar-scanner \
                        -Dsonar.organization=gransapote \
                        -Dsonar.projectKey=gransapote_Lab \
			-Dsonar.sources=. \
                        -Dsonar.host.url=https://sonarcloud.io \
                        -Dsonar.pullrequest.provider='GitHub' \
                        -Dsonar.pullrequest.github.repository='gransapote/lab' \
                        -Dsonar.pullrequest.key='${env.CHANGE_ID}' \
                        -Dsonar.pullrequest.branch='${env.CHANGE_BRANCH}'"
                }
            }
        }
        stage ("Sonar: Espera a respuesta de Sonar por escaneo") {
            steps {
        // Wait for QuaityGate webhook result
                timeout(time: 1, unit: 'HOURS') {
        // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
        /// true = set pipeline to UNSTABLE, false = don't
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage ("Terraform plan") {
            when {  not { branch 'main' } } 
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
        stage ("Ansible No rama Main") {
            when { not { branch 'main' } }
            steps {
                sh "ansible-playbook reto.yml --check"
            }
        }
        stage ("Ansible rama Main") {
            when { branch 'main' }
            steps {
                sh "ansible-playbook reto.yml"
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
