# 🚀 Manual Deployment of a Web Application on AWS EC2

## 📌 Project Overview

This project demonstrates the manual deployment of a Node.js web application on an AWS EC2 Ubuntu instance without using automation tools.

The deployment process includes:

- Launching an AWS EC2 instance
- Connecting to the server using SSH
- Installing Node.js, Git, NGINX, and PM2
- Creating and running a Node.js application
- Configuring NGINX as a reverse proxy
- Hosting the application publicly on AWS infrastructure

This project provides practical experience in:

- Cloud Computing ☁️
- Linux Administration 🐧
- Web Server Configuration 🌐
- Networking & Security 🔒
- Manual Application Deployment 🚀

---

# 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| AWS EC2 | Cloud Virtual Server |
| Ubuntu 22.04 | Operating System |
| Node.js | Backend Runtime |
| Express.js | Web Framework |
| NGINX | Reverse Proxy |
| PM2 | Process Manager |
| Git | Version Control |

---

# 🏗️ Project Architecture

```text
Browser
   ↓
AWS EC2 Public IP
   ↓
NGINX Server (Port 80)
   ↓
Node.js Application (Port 3000)
```

---

# ⚙️ EC2 Instance Configuration

| Configuration | Value |
|---|---|
| Instance Type | t2.micro |
| Operating System | Ubuntu 22.04 |
| Storage | 8 GB |
| Web Server | NGINX |
| Runtime | Node.js |

---

# 🔐 Security Group Configuration

The following inbound rules were configured:

| Type | Port |
|---|---|
| SSH | 22 |
| HTTP | 80 |
| HTTPS | 443 |
| Custom TCP | 3000 |

---

# 🔑 Connect to EC2 Instance

## Give Permission to PEM File

```bash
chmod 400 aws-key.pem
```

## Connect Using SSH

```bash
ssh -i aws-key.pem ubuntu@13.234.75.174
```

---

# 🔄 Update Ubuntu Packages

```bash
sudo apt update && sudo apt upgrade -y
```

---

# 📦 Install Required Packages

## Install Git

```bash
sudo apt install git -y
```

## Install Node.js & npm

```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install nodejs -y
```

## Verify Installation

```bash
node -v
npm -v
git --version
```

---

# 📁 Create Application Directory

```bash
mkdir myapp
cd myapp
```

---

# ⚡ Initialize Node.js Project

```bash
npm init -y
```

---

# 📥 Install Express.js

```bash
npm install express
```

---

# 🧾 Create Application File

## Create app.js

```bash
nano app.js
```

## Add Following Code

```javascript
const express = require('express');

const app = express();

app.get('/', (req, res) => {
    res.send('Application deployed successfully on AWS EC2 🚀');
});

app.listen(3000, () => {
    console.log('Server running on port 3000');
});
```

---

# ▶️ Run Application

```bash
node app.js
```

## Access Application

```text
http://13.234.75.174:3000
```

---

# ⚙️ Install PM2

PM2 is used to keep the application running continuously.

## Install PM2

```bash
sudo npm install pm2 -g
```

## Start Application with PM2

```bash
pm2 start app.js
```

## Save PM2 Configuration

```bash
pm2 save
```

---

# 🌐 Install NGINX

```bash
sudo apt install nginx -y
```

## Start and Enable NGINX

```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```

---

# 🔁 Configure NGINX Reverse Proxy

## Open Configuration File

```bash
sudo nano /etc/nginx/sites-available/default
```

## Replace with Following Configuration

```nginx
server {
    listen 80;

    server_name _;

    location / {
        proxy_pass http://localhost:3000;

        proxy_http_version 1.1;

        proxy_set_header Upgrade $http_upgrade;

        proxy_set_header Connection 'upgrade';

        proxy_set_header Host $host;

        proxy_cache_bypass $http_upgrade;
    }
}
```

---

# ✅ Test NGINX Configuration

```bash
sudo nginx -t
```

---

# 🔄 Restart NGINX

```bash
sudo systemctl restart nginx
```

---

# 🌍 Live Application

## Application URL

```text
http://13.234.75.174/
```

---

# 📊 Useful Commands

## Check PM2 Status

```bash
pm2 status
```

## View PM2 Logs

```bash
pm2 logs
```

## Restart Application

```bash
pm2 restart app
```

## Restart NGINX

```bash
sudo systemctl restart nginx
```

---

# 🎯 Learning Outcomes

Through this project, the following concepts were learned:

- AWS EC2 provisioning
- Linux server management
- SSH connectivity
- Node.js application deployment
- NGINX reverse proxy setup
- Process management using PM2
- Security Group configuration
- Public hosting of applications

---

# 📌 Conclusion

This project demonstrated the complete manual deployment workflow of a Node.js web application on AWS EC2. It provided practical knowledge of configuring cloud infrastructure, deploying applications, and exposing services securely over the internet using NGINX.

---

# 👨‍💻 Author

Siddharth Modanwal
