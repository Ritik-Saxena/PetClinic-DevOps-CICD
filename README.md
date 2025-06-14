# 🌐 End-to-End DevOps Project on AWS

A hands-on, real-world DevOps pipeline built from scratch using Ansible, Jenkins, SonarQube, Nexus, Docker, AWS ECS/ECR, Load Balancer, and Slack Notifications.

---

## 📌 Project Overview

This project showcases a fully automated CI/CD pipeline designed for modern application deployment using best DevOps practices. It features infrastructure automation, containerized deployments, quality gates, and cloud-native scalability—all deployed on Amazon Web Services (AWS).

### Visit for detailed article: https://ritiksaxenaofficial.hashnode.dev/devops-end-to-end-project
---

## 🚀 Tech Stack

| Tool/Service     | Purpose                                 |
|------------------|-----------------------------------------|
| **Ansible**       | Infrastructure as Code (IaC)            |
| **Elastic IP**    | Consistent public IP for services       |
| **Jenkins**       | CI/CD automation                        |
| **SonarQube**     | Code quality analysis                   |
| **Quality Gates** | Build validation                        |
| **Nexus**         | Artifact repository                     |
| **Docker**        | Containerization                        |
| **AWS ECR**       | Container image storage                 |
| **AWS ECS**       | Container orchestration                 |
| **Load Balancer** | High availability and traffic routing   |
| **Slack**         | Real-time notifications                 |

---

## 🔧 Features

- ✅ Infrastructure setup automated using Ansible
- 🧪 Jenkins pipeline triggered on GitHub commits
- 🔍 SonarQube checks with Quality Gates enforcement
- 📦 Artifact management via Nexus Repository
- 🐳 Dockerized app deployment to AWS ECS
- 🔁 Load Balanced ECS services for high availability
- 🔔 Slack integration for build/deploy alerts

---

## 🛠️ Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/devops-project.git
cd devops-project
```

### 2. Provision Infrastructure with Ansible

```bash
ansible-playbook -i inventory setup.yml
```
This sets up Jenkins, SonarQube, Nexus, and Elastic IP configuration.

---

### 3. Create & Configure Jenkins Pipeline

- 🔧 **Create a new Jenkins Pipeline job**
- 🔗 **Connect it to your GitHub repo**
- 🔑 **Add any required credentials** (AWS, GitHub, DockerHub, etc.)
- ⚙️ **Set environment variables** needed for deployment
---

### 4. Add SonarQube Integration & Quality Gates

- 🔍 **Install SonarQube Scanner plugin** in Jenkins
- ⚙️ **Configure SonarQube server** in Jenkins global settings
- 📦 **Run code analysis** using SonarQube scanner in the pipeline
- ✅ **Set up Quality Gates** in SonarQube dashboard
- 🚫 **Break the build** if code doesn’t meet the quality gate threshold

---

### 5. Build & Deploy Docker Image to AWS ECR

- 🐳 **Create a Dockerfile** for your application
- 🔨 **Build the Docker image** in Jenkins pipeline
- 🔐 **Authenticate Jenkins to AWS ECR**
- 🚀 **Push the image** to your ECR repository

---

### 6. Deploy to AWS ECS via Jenkins

- 🏗️ **Create ECS cluster** and define task/service definition
- 📦 **Pull Docker image from ECR** using ECS service
- 🛠️ **Update ECS task definition** in pipeline script
- 📤 **Trigger deployment** from Jenkins
- 🔁 **Attach Load Balancer** to ECS service for traffic routing

---

### 7. Configure Slack Notifications

- 💬 **Create a Slack App** and generate a webhook URL
- 🔌 **Install Slack Notification plugin** in Jenkins
- 🛠️ **Configure webhook URL** in Jenkins global config
- 🔔 **Send notifications** for:
  - Build started
  - Build succeeded
  - Build failed
  - Deployment completed

---

### 📌 Tools Used

- 🧰 **Ansible** – Infrastructure provisioning
- 🔧 **Jenkins** – CI/CD pipeline
- 🧪 **SonarQube** – Code quality analysis
- 📦 **Nexus** – Artifact repository
- 🐳 **Docker** – Containerization
- ☁️ **AWS ECS & ECR** – Container deployment and registry
- 🔗 **Elastic Load Balancer** – Traffic distribution
- 💬 **Slack** – Build/deploy notifications

---

### ✅ Optional Enhancements

- 📈 Add **Prometheus + Grafana** for monitoring
- 🔄 Implement **blue/green or canary deployments**
- 🏗️ Use **Terraform** for IaC instead of Ansible

---

### 🤝 Let’s Connect

If this project helped you or inspired your learning, give it a ⭐ and feel free to:

- Open an issue or discussion for feedback
- Connect with me on [LinkedIn](https://linkedin.com)



