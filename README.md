# AWS 3-Tier Microservices Architecture
# Production-Grade AWS 3-Tier Microservices Architecture

## Architecture Overview
This project provisions a secure, highly available, and fault-tolerant 3-tier microservices architecture on AWS using **Terraform (IaC)** and **Amazon ECS (Fargate)**.

```text
[ Internet / Client Traffic ]
             │
             ▼
[ Application Load Balancer (ALB) ] (Public Subnet)
             │
             ▼ (Port 80 -> Container Port 3000)
[ Amazon ECS Fargate Cluster ] (Private Subnet)
             │
             ▼
[ Database & Storage Tier ] (Isolated Private Subnets / EFS)
