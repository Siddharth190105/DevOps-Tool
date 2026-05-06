# 🚀 Blue-Green Deployment using Kubernetes on AWS EC2

## 📌 Project Overview

This project demonstrates the implementation of the **Blue-Green Deployment strategy** using Kubernetes.
The setup is deployed on an AWS EC2 instance using Minikube.

Blue-Green Deployment ensures **zero downtime** by maintaining two identical environments:

* 🔵 **Blue** → Current live version
* 🟢 **Green** → New version

Traffic is switched between them using a Kubernetes Service.

---

## 🏗️ Architecture

* AWS EC2 Instance
* Minikube (Kubernetes cluster)
* Two Deployments (Blue & Green)
* One NodePort Service (traffic controller)

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
* Kubernetes (Minikube)
* kubectl installed
* Git (for version control)

---

## 🚀 Setup & Execution

### 1️⃣ Start Minikube

```bash
minikube start
```

---

### 2️⃣ Deploy Blue & Green Applications

```bash
kubectl apply -f blue.yaml
kubectl apply -f green.yaml
```

---

### 3️⃣ Create Service

```bash
kubectl apply -f service.yaml
```

---

### 4️⃣ Verify Resources

```bash
kubectl get pods
kubectl get svc
kubectl get endpoints
```

---

## 🌐 Access Application

### Get Minikube IP:

```bash
minikube ip
```

### Open in browser:

```
http://<minikube-ip>:30007
```

---

## 🔄 Blue-Green Switching

### 🔵 To use Blue:

```yaml
selector:
  app: myapp
  version: blue
```

### 🟢 To switch to Green:

```yaml
selector:
  app: myapp
  version: green
```

Apply changes:

```bash
kubectl apply -f service.yaml
```

---

## 🔁 Rollback Strategy

To revert back to the previous version:

```yaml
version: blue
```

Apply again:

```bash
kubectl apply -f service.yaml
```

---

## 🎯 Key Features

* Zero downtime deployment
* Instant rollback capability
* Traffic switching using Kubernetes Service
* Scalable and production-ready approach

---

## 🧠 Conclusion

This project demonstrates how Kubernetes enables seamless deployment transitions using the Blue-Green strategy, ensuring high availability and reliability.

---

## 👨‍💻 Author

**Siddharth Modanwal**
