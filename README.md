This repository demonstrates a complete CI/CD pipeline for the Spring PetClinic application, using modern DevOps practices to automate the build, test, deployment, and monitoring processes. It utilizes Jenkins for continuous integration, SonarQube for static code analysis, and Maven for building the application. The project is containerized with Docker, employing multi-stage builds for efficient image creation. Deployment is handled using Kubernetes for orchestration, utilizing pods, services, and Ingress for managing the application. Infrastructure as Code (IaC) is implemented with Ansible, enabling automated provisioning on AWS EC2 instances. Additionally, the system includes monitoring using Prometheus and Grafana to track application metrics and alerts. Git is used for version control, ensuring collaboration and code management throughout the pipeline.