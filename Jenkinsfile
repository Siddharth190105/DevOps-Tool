pipeline {
    agent any

    environment {
        APP_NAME  = "myapp"
        DEPLOY_DIR = "/opt/myapp"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Checking out from GitHub..."
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo "Compiling with Maven..."
                sh 'mvn clean compile -q'
            }
        }

        stage('Test') {
            steps {
                echo "Running JUnit tests..."
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
                failure {
                    echo "Tests FAILED — deployment skipped."
                }
            }
        }

        stage('Package') {
            when {
                expression { currentBuild.result == null }
            }
            steps {
                echo "Packaging JAR..."
                sh 'mvn package -DskipTests -q'
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        stage('Deploy') {
            when {
                branch 'CI-CD'
                expression { currentBuild.result == null }
            }
            steps {
                echo "Deploying to server..."
                sh 'chmod +x deploy.sh && ./deploy.sh'
            }
        }
    }

    post {
        success { echo "Pipeline completed successfully!" }
        failure { echo "Pipeline FAILED. Check the logs above." }
    }
}
