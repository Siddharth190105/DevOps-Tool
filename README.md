# 🚀 Deploying Spring Boot Application on Kubernetes

A step-by-step guide to deploying a **Spring Boot CRUD application** on a **Kubernetes (Minikube)** cluster hosted on an AWS EC2 instance, complete with a MySQL database, Docker containerization, and a K8S Dashboard.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Architecture](#architecture)
- [Step-by-Step Deployment](#step-by-step-deployment)
- [Testing the API](#testing-the-api)
- [Kubernetes Dashboard](#kubernetes-dashboard)
- [Key Concepts](#key-concepts)

---

## 🌐 Overview

This project demonstrates how to:

- Set up a Kubernetes cluster using **Minikube** on an AWS EC2 instance
- Deploy a **Spring Boot REST API** as a containerized pod
- Connect the app to a **MySQL database** running as a persistent K8S deployment
- Expose the app using **port forwarding**
- Monitor resources via the **Kubernetes Dashboard**

---

## ✅ Prerequisites

| Tool | Version |
|------|---------|
| AWS EC2 | t2.medium (min recommended) |
| Docker | Latest |
| Minikube | Latest |
| kubectl | Latest (stable) |
| Maven | 3.x |
| Git | Latest |
| Docker Hub Account | Required for image push |

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────┐
│           AWS EC2 (t2.medium)           │
│                                         │
│  ┌──────────────────────────────────┐   │
│  │        Minikube Cluster          │   │
│  │                                  │   │
│  │  ┌────────────┐  ┌────────────┐  │   │
│  │  │ SpringBoot │  │   MySQL    │  │   │
│  │  │    Pod     │◄─►    Pod     │  │   │
│  │  └────────────┘  └────────────┘  │   │
│  │         │               │        │   │
│  │  ┌──────┴───────────────┴──────┐ │   │
│  │  │        K8S Services         │ │   │
│  │  └─────────────────────────────┘ │   │
│  └──────────────────────────────────┘   │
│              Port 8080 ▲                │
└──────────────────────────────────────── ┘
                         │
                    🌍 Internet
                    (Postman / Browser)
```

---

## 🛠️ Step-by-Step Deployment

### Step 1 — 🖥️ Launch EC2 Instance

Create a **t2.medium** EC2 instance on AWS (Amazon Linux recommended).

---

### Step 2 — 🐳 Install Docker

```bash
sudo su
yum update -y
yum install docker -y
systemctl enable docker
systemctl start docker
systemctl status docker
docker --version
```

---

### Step 3 — 🔌 Install Conntrack

> **What is Conntrack?**
> Conntrack (Connection Tracking) is a Linux kernel feature that tracks active network connections — including source/destination IPs, ports, and connection states. Kubernetes uses it internally for pod-to-pod networking and service routing.

```bash
yum install conntrack -y
```

---

### Step 4 — ☸️ Install & Start Minikube

```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
/usr/local/bin/minikube start --force --driver=docker

# Verify
/usr/local/bin/minikube version
```

---

### Step 5 — 🧰 Install kubectl

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Verify
/usr/local/bin/kubectl version
```

---

### Step 6 — 📦 Create Project Files

Created the required project structure and configuration files for deploying the Spring Boot application on Kubernetes.

Created:
- ✅ Spring Boot source code
- ✅ Dockerfile
- ✅ `pom.xml`
- ✅ `app-deployment.yaml`
- ✅ `db-deployment.yaml`
- ✅ Application configuration files

Moved into the project directory:

```bash
cd /opt/SpringBootOnK8S_PS

---

### Step 7 — 🗄️ Deploy the Database

```bash
# Check existing pods
/usr/local/bin/kubectl get pods

# Deploy MySQL
/usr/local/bin/kubectl create -f db-deployment.yaml
/usr/local/bin/kubectl get pods

# Verify database inside the container (password: root)
/usr/local/bin/kubectl exec -it <POD_NAME> -- /bin/bash
mysql -u root -p

# Exit MySQL and container when done
exit
exit

# Install Maven
yum install maven -y
mvn -v
```

---

### Step 8 — 🏗️ Build & Push Docker Image

```bash
# Build the image
docker build -t <your_dockerhub_username>/<image_name>:1.0 .

# Verify image
docker images

# Push to Docker Hub
docker login
docker push <your_dockerhub_username>/<image_name>:1.0
```

> 💡 Replace `<your_dockerhub_username>` and `<image_name>` with your own Docker Hub credentials and preferred image name.

---

### Step 9 — 🚀 Deploy the Application

```bash
# Apply the app deployment
/usr/local/bin/kubectl apply -f app-deployment.yaml

# Check pods and services
/usr/local/bin/kubectl get pods
/usr/local/bin/kubectl get svc

# Get Minikube IP
/usr/local/bin/minikube ip

# Enable port forwarding (runs in background)
/usr/local/bin/kubectl port-forward --address 0.0.0.0 svc/springboot-crud-svc 8080:8080 &
```

> 🔁 **What is Port Forwarding?**
> Port forwarding redirects traffic from a port on the EC2 host (`0.0.0.0:8080`) into the Kubernetes service (`springboot-crud-svc:8080`), making the app accessible from outside the cluster.

---

### Step 10 — 🧪 Test with Postman

1. Open **Postman**
2. Send requests to `http://<EC2_PUBLIC_IP>:8080/<endpoint>`
3. Test GET, POST, PUT, DELETE operations
4. Verify data is persisted in MySQL:

```bash
/usr/local/bin/kubectl exec -it <mysql_pod_name> -- /bin/bash
mysql -u root -p
# Run your SELECT queries here
```

---

### Step 11 — 📊 Access the Kubernetes Dashboard

**Terminal 1 — Start the proxy:**
```bash
/usr/local/bin/kubectl proxy --address='0.0.0.0' --accept-hosts='^*$'
# Proxy starts on port 8001
```

**Terminal 2 — Get the dashboard URL:**
```bash
/usr/local/bin/minikube dashboard
```

**Open in browser:**
```
http://<EC2_PUBLIC_IP>:8001/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/
```

> 🖥️ Replace `<EC2_PUBLIC_IP>` with your actual EC2 public IP address.

---

## 🔬 Testing the API

Use **Postman** or `curl` to test the CRUD endpoints:

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/employees` | Fetch all employees |
| `POST` | `/api/employees` | Create a new employee |
| `PUT` | `/api/employees/{id}` | Update an employee |
| `DELETE` | `/api/employees/{id}` | Delete an employee |

---

## 💡 Key Concepts

| Concept | Description |
|---------|-------------|
| 🐳 **Docker** | Containerizes the Spring Boot app and its dependencies |
| ☸️ **Minikube** | Runs a single-node Kubernetes cluster locally |
| 🧰 **kubectl** | CLI tool to manage Kubernetes resources |
| 🔌 **Conntrack** | Linux kernel module for K8S network connection tracking |
| 📄 **YAML Manifests** | Define deployments, services, and persistent volumes in K8S |
| 🔁 **Port Forwarding** | Exposes internal K8S services to external traffic |
| 📊 **K8S Dashboard** | Web UI for monitoring pods, deployments, and services |

---

## ⚠️ Common Issues & Fixes

- **`exec` command error** — Always use `--` before the shell path:
  ```bash
  kubectl exec -it <POD_NAME> -- /bin/bash  ✅
  kubectl exec -it <POD_NAME>/bin/bash       ❌
  ```
- **Minikube won't start** — Ensure Docker is running: `systemctl status docker`
- **Port already in use** — Kill the existing process: `fuser -k 8080/tcp`
- **Image pull error** — Confirm you pushed the image to Docker Hub and the image name in `app-deployment.yaml` matches exactly

---

## 👨‍💻 Author

**Siddharth Modanwal**
