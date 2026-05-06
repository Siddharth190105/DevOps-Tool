# 🚀 Blue-Green Deployment using Kubernetes on AWS EC2

## 📌 Project Overview

This project demonstrates the implementation of the **Blue-Green Deployment strategy** using Kubernetes.
The setup is deployed on an AWS EC2 instance using Minikube.

Blue-Green Deployment ensures **zero downtime** by maintaining two identical environments:

* 🔵 **Blue** → Current live version
* 🟢 **Green** → New version

Traffic is switched between them using a Kubernetes Service.

---

## ☁️ Infrastructure Setup

* Created an **Amazon EC2 instance (Ubuntu)**
* Installed **Docker, kubectl, and Minikube**
* Configured Minikube cluster on EC2
* Used EC2 as the host machine to run Kubernetes workloads

---

## 🏗️ Architecture

* AWS EC2 Instance
* Minikube (Kubernetes cluster)
* Blue Deployment (v1)
* Green Deployment (v2)
* NodePort Service (traffic controller)

---

## 📂 Project Structure

```
blue-green-deployment/
│── blue.yaml       # Blue deployment (blue background)
│── green.yaml      # Green deployment (green background)
│── service.yaml    # Service to switch traffic
│── README.md
```

---

## ⚙️ Prerequisites

* AWS EC2 instance (Ubuntu)
* Docker installed
* Minikube installed
* kubectl installed
* Git installed

---

## 🚀 Setup & Execution

### 1️⃣ Start Minikube

```
minikube start
```

---

### 2️⃣ Deploy Blue & Green Applications

```
kubectl apply -f blue.yaml
kubectl apply -f green.yaml
```

---

### 3️⃣ Create Service

```
kubectl apply -f service.yaml
```

---

### 4️⃣ Verify Deployment

```
kubectl get pods
kubectl get svc
kubectl get endpoints
```

---

## 🌐 Access Application

### Get Minikube IP:

```
minikube ip
```

### Open in browser (inside EC2):

```
http://<minikube-ip>:30007
```

### External access (via port-forward):

```
kubectl port-forward svc/my-service 8080:80 --address 0.0.0.0
```

Open in browser:

```
http://<EC2-public-ip>:8080
```

---

## 🔄 Blue-Green Deployment Switch

### 🔵 Blue (Default)

```
selector:
  app: myapp
  version: blue
```

### 🟢 Switch to Green

Update `service.yaml`:

```
selector:
  app: myapp
  version: green
```

Apply:

```
kubectl apply -f service.yaml
```

---

## 🔁 Rollback (Green → Blue)

```
selector:
  app: myapp
  version: blue
```

Apply again:

```
kubectl apply -f service.yaml
```

---

## 🎯 Key Features

* Zero downtime deployment
* Instant traffic switching
* Easy rollback capability
* Runs on cloud infrastructure (AWS EC2)

---

## 🧠 Conclusion

This project demonstrates how Kubernetes enables seamless application updates using the Blue-Green deployment strategy.
By leveraging AWS EC2 and Minikube, the setup simulates a real-world deployment environment.

---

## 👨‍💻 Author

**Siddharth Modanwal**
