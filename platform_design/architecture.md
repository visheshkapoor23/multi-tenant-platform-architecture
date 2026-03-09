# Platform Architecture

## Overview

This document describes the architecture of a **cloud-native multi-tenant application platform** designed to support **20+ engineering teams (~250 engineers)** with scalability to **50+ teams**.

The platform is built using modern **platform engineering and cloud-native principles**:

- Kubernetes-based application platform
- GitOps driven CI/CD
- Infrastructure as Code using Terraform
- Strong tenant isolation
- Full observability using OpenTelemetry

The platform is deployed in **AWS eu-central-1** and uses **Amazon EKS** as the primary compute platform.

---

# High-Level Architecture

The platform consists of several logical layers:

- Developer Layer
- CI/CD Layer
- Platform Layer
- Data Layer
- Observability Layer

---

## Architecture Diagram

```mermaid
flowchart TB

subgraph Developers
Dev[Engineering Teams]
end

subgraph SourceControl
Git[GitHub Repositories]
end

subgraph CI
CI[GitHub Actions]
ECR[Amazon ECR]
end

subgraph GitOps
Argo[ArgoCD]
end

subgraph AWS

subgraph Networking
VPC[VPC]
Public[Public Subnets]
Private[Private Subnets]
end

subgraph EKSCluster
Ingress[ALB Ingress Controller]
Mesh[Service Mesh]

subgraph TenantA
A[Team A Workloads]
end

subgraph TenantB
B[Team B Workloads]
end

subgraph TenantN
N[Team N Workloads]
end

OTel[OpenTelemetry Collector]
end

subgraph DataLayer
RDS[(Amazon RDS)]
S3[(Artifact Storage)]
end

subgraph Observability
NR[New Relic]
end

end

Dev --> Git
Git --> CI
CI --> ECR
CI --> Argo
Argo --> EKSCluster

A --> RDS
B --> RDS
N --> RDS

A --> S3
B --> S3
N --> S3

A --> OTel
B --> OTel
N --> OTel

OTel --> NR
```

---

# Platform Components

## Developer Layer

Engineering teams develop application services and push code to **GitHub repositories**.

Each repository contains:

- application source code
- container build configuration
- Kubernetes manifests or Helm charts

---

## CI Layer

Continuous Integration pipelines run using **GitHub Actions**.

Pipeline responsibilities:

- build container images
- run tests
- perform security scans
- push images to **Amazon ECR**

---

## GitOps Deployment Layer

The platform uses a **GitOps model** for deployments.

Deployment process:

```
Developer → GitHub → CI Pipeline → Container Registry → GitOps Repository → ArgoCD → Kubernetes Deployment
```

ArgoCD continuously synchronizes the cluster with the desired state stored in Git.

Benefits include:

- reproducible deployments
- automated rollback
- strong auditability

---

# Platform Layer

The platform runs on **Amazon EKS** inside a dedicated VPC.

Key components include:

- EKS cluster with managed node groups
- ALB ingress controller
- service mesh for traffic management
- OpenTelemetry collectors

Worker nodes run inside **private subnets** to improve security.

---

# Data Layer

Persistent storage is provided using managed AWS services.

### Amazon RDS

Used for relational application data.

Features:

- Multi-AZ deployment
- automated backups
- private subnet networking

### Amazon S3

Used for:

- CI/CD artifacts
- logs
- backups
- object storage

---

# Multi-Account AWS Architecture

The platform follows a **multi-account architecture** to improve security and operational separation.

### Shared Services Account

Contains shared infrastructure such as:

- Route53 DNS
- Secrets Manager
- artifact storage
- observability integrations

### Platform Account

Hosts the application platform:

- VPC networking
- Amazon EKS cluster
- ingress controllers
- GitOps controllers

### Data Account

Hosts stateful data services:

- Amazon RDS databases
- backups
- long-term storage

This architecture reduces blast radius and improves cost allocation.

---

# Multi-Tenancy Isolation Strategy

Tenant isolation is implemented across multiple layers.

## Kubernetes Namespace Isolation

Each engineering team receives a dedicated namespace.

Example:

```
team-a
team-b
team-c
```

Each namespace contains:

- deployments
- services
- secrets
- configmaps

Isolation mechanisms include:

- RBAC
- resource quotas
- network policies

---

## IAM Isolation

AWS access is managed using **IAM Roles for Service Accounts (IRSA)**.

Each workload receives a dedicated IAM role allowing access only to required AWS resources.

Examples include:

- access to team-specific S3 buckets
- access to database credentials
- access to secrets

---

## Network Isolation

Kubernetes **Network Policies** restrict communication between namespaces.

This prevents:

- cross-tenant communication
- lateral movement within the cluster

Ingress traffic is routed through the **ALB ingress controller**.

---

# Security Model

The platform follows cloud security best practices:

- IAM least privilege
- IAM Roles for Service Accounts
- Kubernetes RBAC
- network policies
- private worker nodes
- secrets stored in AWS Secrets Manager

---

# Scalability Strategy (20 → 50+ Teams)

The platform is designed to scale horizontally.

### Cluster Autoscaling

Worker nodes scale automatically using:

- cluster autoscaler
- managed node groups

### Namespace Automation

New teams can be onboarded using Terraform modules that automatically create:

- namespaces
- RBAC rules
- network policies
- resource quotas

### CI/CD Scalability

GitHub Actions supports parallel pipeline execution across many repositories.

---

# Observability Integration

The platform implements full observability using **OpenTelemetry and New Relic**.

Telemetry collected includes:

- infrastructure metrics
- application metrics
- distributed traces
- logs
- CI/CD pipeline metrics

Telemetry pipeline:

```
Application
   ↓
OpenTelemetry SDK
   ↓
OpenTelemetry Collector
   ↓
New Relic
   ↓
Dashboards and Alerts
```

Tenant-level attributes allow filtering metrics per team.

---

# Design Trade-Offs

## Shared Cluster vs Dedicated Clusters

A shared EKS cluster was selected to:

- reduce infrastructure costs
- simplify cluster management
- improve resource utilization

The trade-off is the need for strong namespace isolation.

---

## GitOps vs Traditional Deployments

GitOps provides:

- declarative infrastructure
- strong auditability
- automated reconciliation

However, it requires teams to adopt Git-based deployment workflows.

---

# Conclusion

This architecture provides a scalable and secure platform for running multi-tenant applications on AWS.

The design focuses on:

- platform engineering best practices
- strong tenant isolation
- automated infrastructure
- full observability

This enables engineering teams to deploy and operate applications efficiently while maintaining governance and operational visibility.