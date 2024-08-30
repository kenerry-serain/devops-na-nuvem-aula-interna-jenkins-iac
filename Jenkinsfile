pipeline {
    agent any

    environment{
        AWS_REGION = "us-east-1"
        AWS_ACCOUNT_ID = "968225077300"
    }

    stages {
        stage('Checkout App Repository') {
            steps {
                checkout scmGit(
                    branches: [[name: 'main']], 
                    extensions: [], 
                    userRemoteConfigs: [[url: 'https://github.com/kenerry-serain/devops-na-nuvem-aula-interna-jenkins-app']]
                )
            }
        }

        stage('ECR Login') {
            steps {
                sh("aws ecr get-login-password --region ${env.AWS_REGION} \
                    | docker login --username AWS --password-stdin ${env.AWS_ACCOUNT_ID}.dkr.ecr.${env.AWS_REGION}.amazonaws.com")
            }
        }

        stage('Docker Build') {
            steps {
                sh("docker build -f ./frontend/youtube-live-app/Dockerfile \
                    -t ${env.AWS_ACCOUNT_ID}.dkr.ecr.${env.AWS_REGION}.amazonaws.com/jenkins/production/frontend:${env.BUILD_ID} \
                    ./frontend/youtube-live-app/")
            }
        }

        stage('Docker Push') {
            steps {
                sh("docker push ${env.AWS_ACCOUNT_ID}.dkr.ecr.${env.AWS_REGION}.amazonaws.com/jenkins/production/frontend:${env.BUILD_ID}")
            }
        }

        stage('Checkout GitOps Repository') {
            steps {
                checkout scmGit(
                    branches: [[name: 'main']], 
                    extensions: [], 
                    userRemoteConfigs: [[url: 'https://<TOKEN>@github.com/kenerry-serain/devops-na-nuvem-aula-interna-jenkins-gitops']]
                )
            }
        }

        stage('Kustomize Edit Image') {
            steps {
                sh("kustomize edit set image ${env.AWS_ACCOUNT_ID}.dkr.ecr.${env.AWS_REGION}.amazonaws.com/jenkins/production/frontend=${env.AWS_ACCOUNT_ID}.dkr.ecr.${env.AWS_REGION}.amazonaws.com/jenkins/production/frontend:${env.BUILD_ID}")
            }
        }

        stage('Commit/Push GitOps Changes') {
            steps {
                sh("git config user.name \"github-actions[bot]\"")
                sh("git config user.email \"41898282+github-actions[bot]@users.noreply.github.com\"")
                sh("git add ./kustomization.yml")
                sh("git commit -m \"[Jenkins] Changing frontend image tag to ${env.AWS_ACCOUNT_ID}.dkr.ecr.${env.AWS_REGION}.amazonaws.com/jenkins/production/frontend:${env.BUILD_ID}\"")
                sh("git push origin HEAD:main")
            }
        }
    }
}
