def COLOR_MAP = [
        "SUCCESS": "good",
        "UNSTABLE": "warning",
        "FAILURE": "danger"
]

def petclinicImage      // for storing built Docker image

pipeline {
    agent any

    tools {
        jdk "OpenJDK17"
        maven "Maven3"
    }

    environment {
        // Sonar env variables
        SONAR_SERVER = "sonar-server"
        SONAR_SCANNER = "sonar-scanner"
        SONAR_PROJECT_KEY = "petclinic-ccd"
        SONAR_PROJECT_NAME = "petclinic-cicd"
        SONAR_PROJECT_VERSION = "v1"

        // Slack workspace
        SLACK_CHANNEL = "#petclinic-cicd"

        // AWS ECR env variables
        REGISTRY_CREDENTIAL = "ecr:us-east-1:iam-jenkins-ecr"
        APP_REGISTRY = "<AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/petclinic/petclinic-repo"
        REGISTRY_URL = "https://<AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com"

        // AWS ECS env variables
        CLUSTER_NAME = "petclinic-cluster-ecs"
        SERVICE_NAME = "petclinic-ecs-service"
        AWS_REGION = "us-east-1"
    }

    stages {
        stage('Fetch github source code') {
            steps {
                git branch: 'main', url: 'https://github.com/jaiswaladi246/Petclinic.git'
            }
        }

        stage('Build the artifact') {
            steps {
                sh 'mvn clean install'
            }
            post {
                success {
                    archiveArtifacts artifacts: '**/*.war'
                    echo 'Successfully archived the artifact!!!'
                }
                failure {
                    echo 'Failed to archive the artifact...'
                }
            }
        }

        stage('Checkstyle analysis') {
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
        }

        stage('Sonar Analysis') {
            environment {
                SONAR_SCANNER = tool "sonar-scanner"
            }

            steps {
                withSonarQubeEnv("${SONAR_SERVER}") {
                    sh '''
                        ${SONAR_SCANNER}/bin/sonar-scanner \
                        -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                        -Dsonar.projectName=${SONAR_PROJECT_NAME} \
                        -Dsonar.projectVersion=${SONAR_PROJECT_VERSION} \
                        -Dsonar.sources=src/main/java \
                        -Dsonar.tests=src/test/java \
                        -Dsonar.junit.reportPaths=target/surefire-reports \
                        -Dsonar.java.binaries=target/classes \
                        -Dsonar.jacoco.reportPaths=target/jacoco.exec \
                        -Dsonar.checkstyle.reportPaths=target/checkstyle-result.xml
                    '''
                }
            }
        }

        stage('SonarQube Quality Gate') {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    // waitForQualityGate abortPipeline: true
                    script {
                        def gateStatus = waitForQualityGate()
                        if (gateStatus.status != 'OK') {
                            error 'Pipeline aborted due to quality gate failure: ${gateStatus.status}'
                        }
                    }
                }
            }
        }

        stage('Upload artifact to Nexus') {
            steps {
                script {
                    def pom = readMavenPom file: 'pom.xml'
                    def groupId = pom.groupId
                    def packaging = pom.packaging
                    def version = pom.version

                    nexusArtifactUploader(
                        nexusVersion: 'nexus3',
                        protocol: 'http',
                        nexusUrl: '34.207.174.152:8081',
                        groupId: groupId,
                        version: "${version}_ID${env.BUILD_ID}_D${env.BUILD_TIMESTAMP}",
                        repository: 'petclinic-artifact',
                        credentialsId: 'nexus-creds',
                        artifacts: [
                            [
                                artifactId: 'petclinic',
                                classifier: '',
                                file: "target/petclinic.${packaging}",
                                type: packaging
                            ]
                        ]
                    )
                }
            }
        }

        stage('Build project docker image') {
            steps {
                script {
                    petclinicImage = docker.build("${APP_REGISTRY}:${env.BUILD_ID}", '.')
                }
            }
        }

        stage('Uploading docker image to registry') {
            steps {
                script {
                    docker.withRegistry(REGISTRY_URL, REGISTRY_CREDENTIAL) {
                        // push image
                        petclinicImage.push("${env.BUILD_NUMBER}")
                        petclinicImage.push("latest")
                    }
                }
            }
        }

        stage('Deploying on ECS') {
            steps {
                withAWS(credentials: 'awscreds', region: "${AWS_REGION}") {
                    script {
                        sh "aws ecs update-service --cluster ${CLUSTER_NAME} --service ${SERVICE_NAME} --force-new-deployment"
                    }
                }
            }
        }

    }
    post {
        always {
            slackSend(
                channel: "${SLACK_CHANNEL}",
                color: COLOR_MAP[currentBuild.currentResult],
                message: "Pipeline ${currentBuild.currentResult} for job '${env.JOB_NAME}' having build ID - ${env.BUILD_ID}. \nCheck out for more information: ${env.BUILD_URL}")
        }
    }
}
