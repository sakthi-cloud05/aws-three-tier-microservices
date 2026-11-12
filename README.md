# 🏗️ Highly Available AWS 3-Tier Microservices Architecture (Terraform)

A production-grade, multi-Availability Zone cloud infrastructure provisioned via **Terraform** on **Amazon Web Services (AWS)**. This architecture implements traffic routing through an **Application Load Balancer (ALB)** with path-based rules, containerized microservices on **Amazon ECS**, private subnet isolation, and shared persistent storage via **Amazon EFS (NFSv4)**.

---

## 🗺️ Cloud Architecture Diagram

```mermaid
flowchart TB
    Internet((Internet Users)) -->|HTTP :80| ALB[Application Load Balancer\nPublic Subnets AZ-1 & AZ-2]
    
    ALB -->|Default Path /*| WebTG[Web Target Group :80]
    ALB -->|API Path /api/*| ApiTG[API Target Group :8080]
    
    subgraph VPC [Custom VPC 10.0.0.0/16 - Private Subnets]
        WebTG --> ECS1[Amazon ECS Tasks\nAZ-1 Private Subnet]
        ApiTG --> ECS2[Amazon ECS Tasks\nAZ-2 Private Subnet]
        ECS1 <-->|NFSv4 Port 2049\nTLS Encrypted| EFS[(Amazon EFS\nShared File System)]
        ECS2 <-->|NFSv4 Port 2049\nTLS Encrypted| EFS
    end
