# Docker Foundations Assignment

## 📌 Objective

The objective of this assignment was to understand the fundamentals of Docker and gain hands-on experience with containers, images, and multi-container applications using Docker Compose.

---

## 🟢 Stage 1 – Docker Basics

In this stage, I learned the core concepts of Docker:

* **Images** act as blueprints for containers.
* **Containers** are running instances of images.
* Executed basic commands like:

  * `docker run hello-world`
  * `docker ps` and `docker ps -a`
  * `docker images`

This helped me understand how Docker pulls images from Docker Hub and runs applications in isolated environments.

---

## 🔵 Stage 2 – Multi-Container Application (Docker Compose)

In this stage, I worked with **Docker Compose** to manage multiple containers.

* Created a `docker-compose.yml` file
* Defined services:

  * **Web server** using NGINX
  * **Database** using MySQL
* Used:

  * `docker compose up -d` to start services
  * `docker ps` to verify running containers
* Accessed the web application via `http://localhost:8080`

This stage helped me understand how multiple containers communicate using Docker networks and run together as a single application.

---

## 🟣 Stage 3 – Advanced Concepts (Bonus)

In this stage, I explored advanced Docker concepts:

* Created a custom image using a **Dockerfile**
* Used `docker build` to build my own image
* Ran the container using `docker run -p 8081:80 myapp`
* Deployed a custom web page using NGINX

Additionally, I learned:

* Importance of **volumes** for persistent storage
* Basics of container networking
* Introduction to orchestration tools like Docker Swarm and Kubernetes

---

## 🧠 Key Learnings

* Docker simplifies application deployment using containers
* Containers ensure consistency across different environments
* Docker Compose helps manage multi-container applications efficiently
* Custom images allow developers to package their own applications
* Networking enables communication between services

---

## 🚀 Conclusion

This assignment provided practical experience with Docker, from basic container execution to multi-container deployment and custom image creation. I am now confident in using Docker for building and running containerized applications in real-world scenarios.

---
