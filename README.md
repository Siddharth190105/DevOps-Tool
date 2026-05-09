# 🚀 AWS Infrastructure Automation Using Terraform

## 📌 Project Overview

This project demonstrates the automation of AWS cloud infrastructure using Terraform. The infrastructure is designed to host containerized applications in a secure, scalable, and highly available environment.

The architecture includes:

- 🌐 VPC with Public & Private Subnets
- 🔒 Security Groups & IAM Configuration
- ⚖️ Application Load Balancer (ALB)
- 🐳 ECS Cluster for Containerized Applications
- 🗄️ RDS PostgreSQL Database
- 🌍 Internet Gateway & NAT Gateway
- 📈 Scalable and Modular Infrastructure

The deployment is fully automated using Terraform Infrastructure as Code (IaC).

---

# 🏗️ Architecture

```text
                Internet
                    │
                    ▼
        Application Load Balancer
                    │
                    ▼
           ECS Cluster (EC2)
                    │
                    ▼
          RDS PostgreSQL Database
```

---

# ☁️ AWS Services Used

| Service | Purpose |
|----------|----------|
| VPC | Network Isolation |
| Public Subnets | Internet-facing Resources |
| Private Subnets | Secure Internal Resources |
| Internet Gateway | Public Internet Access |
| NAT Gateway | Secure Outbound Access |
| ECS | Container Orchestration |
| ALB | Traffic Distribution |
| RDS PostgreSQL | Managed Database |
| Security Groups | Firewall Rules |
| IAM | Access Management |
| CloudWatch | Monitoring & Logging |

---

# 🛠️ Technologies Used

- Terraform
- AWS
- ECS
- RDS PostgreSQL
- Application Load Balancer
- VPC Networking
- Git & GitHub

---

# 📂 Project Structure

```text
terraform-ecs-project/
│
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── vpc.tf
├── security.tf
├── alb.tf
├── ecs.tf
├── rds.tf
├── outputs.tf
├── .gitignore
└── README.md
```

---

# 🌍 AWS Region

```text
ap-south-1
```

Availability Zones Used:

- ap-south-1a
- ap-south-1b

---

# 🔧 Prerequisites

Before deployment, ensure the following are installed:

- Terraform
- AWS CLI
- Git
- AWS Account

---

# 🔑 Configure AWS Credentials

Run the following command:

```bash
aws configure
```

Provide:

```text
AWS Access Key ID
AWS Secret Access Key
Region: ap-south-1
Output Format: json
```

---

# 🚀 Deployment Steps

## 1️⃣ Initialize Terraform

```bash
terraform init
```

---

## 2️⃣ Validate Configuration

```bash
terraform validate
```

---

## 3️⃣ Preview Infrastructure

```bash
terraform plan
```

---

## 4️⃣ Deploy Infrastructure

```bash
terraform apply
```

Type:

```text
yes
```

---

# 📸 Resources Created

The Terraform configuration provisions:

✅ VPC  
✅ Public Subnets  
✅ Private Subnets  
✅ Internet Gateway  
✅ NAT Gateway  
✅ Route Tables  
✅ Security Groups  
✅ ECS Cluster  
✅ Application Load Balancer  
✅ Target Groups & Listener  
✅ PostgreSQL RDS Database  

---

# 🔒 Security Features

- ECS deployed in private subnets
- RDS database not publicly accessible
- Security groups restrict unnecessary access
- Least privilege architecture
- NAT Gateway for secure outbound internet access

---

# 📈 Scalability Features

- Multi-AZ architecture
- ECS Cluster support
- Load Balancer integration
- Modular Terraform configuration

---

# 📊 Monitoring

- AWS CloudWatch support
- VPC Flow Logs support
- RDS monitoring enabled

---

# 🧹 Destroy Infrastructure

To avoid AWS charges, destroy all resources after testing:

```bash
terraform destroy
```

---

# 📷 Screenshots Included

- Terraform Init
- Terraform Validate
- Terraform Apply
- VPC & Subnets
- NAT Gateway
- ALB
- ECS Cluster
- RDS PostgreSQL
- Security Groups

---

# 👨‍💻 Author

Siddharth Modanwal

---

# 📚 Learning Outcomes

Through this project, the following concepts were learned:

- Infrastructure as Code (IaC)
- Terraform Resource Management
- AWS Networking
- ECS Container Deployment
- RDS Configuration
- Load Balancing
- Cloud Security Best Practices
- Git & GitHub Workflow

---

# ⭐ Conclusion

This project successfully automates the deployment of a secure and scalable AWS infrastructure using Terraform. The architecture follows cloud best practices and demonstrates real-world DevOps and Infrastructure Automation concepts.
