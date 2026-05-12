# Jenkins CI/CD Pipeline — DevOps Assignment

A complete CI/CD pipeline built on AWS EC2 using Jenkins, Maven, JUnit, and GitHub webhooks. Every push to the `CI-CD` branch automatically triggers a full build, test, and deployment cycle with zero manual intervention.

---

## Project Overview

This project demonstrates how to set up an automated CI/CD pipeline from scratch using Jenkins hosted on an AWS EC2 instance. The pipeline pulls code from GitHub, compiles it with Maven, runs JUnit tests, packages the JAR, and deploys it to the server automatically on every code push.

---

## Tech Stack

| Tool | Purpose |
|---|---|
| AWS EC2 (Ubuntu 22.04) | Cloud server to host Jenkins |
| Java 21 (OpenJDK) | Runtime environment |
| Jenkins | CI/CD automation server |
| Maven | Build and dependency management |
| JUnit 4 | Automated unit testing |
| Git + GitHub | Version control and source repository |
| GitHub Webhook | Triggers Jenkins on every push |
| Bash | Deployment scripting |

---

## Architecture

```
Developer pushes code to GitHub (CI-CD branch)
            │
            ▼
    GitHub Webhook fires
            │
            ▼
    Jenkins on AWS EC2
            │
    ┌───────▼────────┐
    │  Checkout SCM  │  ← pulls latest code from GitHub
    └───────┬────────┘
            │
    ┌───────▼────────┐
    │     Build      │  ← mvn clean compile
    └───────┬────────┘
            │
    ┌───────▼────────┐
    │     Test       │  ← mvn test (3 JUnit tests)
    └───────┬────────┘
            │
    ┌───────▼────────┐
    │    Package     │  ← mvn package → myapp.jar
    └───────┬────────┘
            │
    ┌───────▼────────┐
    │    Deploy      │  ← copies JAR to /opt/myapp
    └────────────────┘
```

---

## Project Structure

```
DevOps-Tool/
├── src/
│   ├── main/
│   │   └── java/
│   │       └── com/example/
│   │           └── App.java          # Main application
│   └── test/
│       └── java/
│           └── com/example/
│               └── AppTest.java      # JUnit test cases
├── Jenkinsfile                        # Pipeline definition
├── deploy.sh                          # Deployment script
├── pom.xml                            # Maven build config
└── README.md
```

---

## Pipeline Stages

### 1. Checkout
Pulls the latest code from the `CI-CD` branch of the GitHub repository using stored credentials.

### 2. Build
Compiles the Java source code using Maven.
```bash
mvn clean compile
```

### 3. Test
Runs all JUnit test cases. If any test fails, the pipeline stops and deployment is skipped.
```bash
mvn test
```
Test results are published to the Jenkins dashboard automatically.

### 4. Package
Packages the compiled code into a runnable JAR file and archives it as a build artifact.
```bash
mvn package -DskipTests
```

### 5. Deploy
Copies the JAR to `/opt/myapp/` on the server and starts the application.
```bash
./deploy.sh
```

---

## Setup Instructions

### Prerequisites
- AWS account
- GitHub account with a Personal Access Token (`repo` + `admin:repo_hook` scopes)

### Step 1 — Launch EC2 Instance
- AMI: Ubuntu Server 22.04 LTS
- Instance type: `t3.medium`
- Security group inbound rules: SSH (22), HTTP (8080), Jenkins agent (50000)

### Step 2 — Install Java 21
```bash
sudo apt update
sudo apt install openjdk-21-jdk -y
java -version
```

### Step 3 — Install Jenkins
```bash
sudo gpg --batch --yes --keyserver keyserver.ubuntu.com \
  --recv-keys 7198F4B714ABFC68

sudo gpg --batch --yes --export 7198F4B714ABFC68 | \
  sudo tee /usr/share/keyrings/jenkins-keyring.gpg > /dev/null

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/jenkins-keyring.gpg] \
  https://pkg.jenkins.io/debian-stable binary/" | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update && sudo apt install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

### Step 4 — Install Build Tools
```bash
sudo apt install git maven -y
```

### Step 5 — Configure Jenkins
1. Open `http://<ec2-public-ip>:8080`
2. Unlock using `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
3. Install suggested plugins
4. Install additional plugins: GitHub Integration Plugin, Maven Integration plugin, SSH Agent Plugin

### Step 6 — Add GitHub Credentials
- Go to **Manage Jenkins → Credentials → Global → Add Credentials**
- Kind: Username with password
- Username: GitHub username
- Password: Personal Access Token
- ID: `github-credentials`

### Step 7 — Create Pipeline Job
- New Item → Pipeline → name: `myapp-pipeline`
- Build Triggers: check **GitHub hook trigger for GITScm polling**
- Pipeline → Definition: Pipeline script from SCM
- SCM: Git → Repository URL → Credentials → Branch: `*/CI-CD`
- Script Path: `Jenkinsfile`

### Step 8 — Set up GitHub Webhook
- GitHub repo → Settings → Webhooks → Add webhook
- Payload URL: `http://<ec2-public-ip>:8080/github-webhook/`
- Content type: `application/json`
- Trigger: Just the push event

### Step 9 — Grant Jenkins Deploy Permissions
```bash
echo "jenkins ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
sudo mkdir -p /opt/myapp
sudo chown -R jenkins:jenkins /opt/myapp
```

---

## JUnit Test Cases

| Test | Description | Expected Result |
|---|---|---|
| `testGreet()` | Tests the greet() method output | `"Hello, Jenkins!"` |
| `testAdd()` | Tests addition of two positive numbers | `5` |
| `testAddNegative()` | Tests addition with a negative number | `-1` |

---

## Jenkinsfile

```groovy
pipeline {
    agent any

    environment {
        APP_NAME   = "myapp"
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
                always { junit 'target/surefire-reports/*.xml' }
                failure { echo "Tests FAILED — deployment skipped." }
            }
        }
        stage('Package') {
            when { expression { currentBuild.result == null } }
            steps {
                echo "Packaging JAR..."
                sh 'mvn package -DskipTests -q'
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
        stage('Deploy') {
            when { expression { currentBuild.result == null } }
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
```

---

## Key Learnings

- Setting up a production-grade CI/CD pipeline on a real cloud server
- Debugging Jenkins installation issues on Ubuntu 24.04 (GPG keys, Java version)
- Writing a declarative Jenkinsfile with conditional stage execution
- Integrating GitHub webhooks for automatic pipeline triggering
- Running automated JUnit tests inside a Jenkins pipeline
- Deploying applications automatically after successful test runs
- Managing Jenkins credentials and server permissions securely

---

## Challenges Faced & Solutions

| Challenge | Solution |
|---|---|
| Jenkins GPG key verification failed on Ubuntu 24.04 | Fetched key directly from keyserver using the exact key ID `7198F4B714ABFC68` |
| Jenkins required Java 21 but Java 17 was installed | Installed OpenJDK 21 and updated `update-alternatives` |
| Deploy stage skipped due to `branch` condition | Removed branch condition — not supported in standard Pipeline jobs |
| Jenkins could not run `sudo` in deploy script | Added `jenkins ALL=(ALL) NOPASSWD: ALL` to `/etc/sudoers` |

---

## Author

**Siddharth Modanwal**  
DevOps Assignment — Jenkins CI/CD Pipeline on AWS EC2
