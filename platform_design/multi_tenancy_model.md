# Multi-Tenancy Isolation Model

## Overview

The platform supports multiple engineering teams deploying workloads on a shared Kubernetes infrastructure while ensuring strong tenant isolation.

Each engineering team is treated as a **tenant** and receives isolated resources within the platform.

The isolation strategy is implemented across multiple layers:

- Kubernetes namespaces
- RBAC authorization
- Network policies
- IAM roles
- Resource quotas
- Service mesh traffic control

This layered approach ensures that tenants cannot access or interfere with other teams’ workloads.

---

# Tenant Model

Each engineering team is assigned a dedicated Kubernetes namespace.

Example:

team-a
team-b
team-c

Each namespace contains:

- application deployments
- services
- secrets
- configmaps
- ingress resources

This model enables multiple teams to share the same EKS cluster while maintaining isolation.

---

# Kubernetes Namespace Isolation

Namespaces provide logical isolation between tenants.

Each namespace contains only resources owned by the tenant.

Example namespace structure:

team-a namespace
- deployment
- service
- secrets
- configmaps

team-b namespace
- deployment
- service
- secrets
- configmaps

Cross-namespace resource access is restricted by RBAC and network policies.

---

# RBAC Authorization

Role-Based Access Control ensures that teams can only access resources within their own namespace.

Example permissions:

team-a developers can:

- create deployments in team-a namespace
- view logs in team-a namespace
- update services in team-a namespace

They cannot:

- access team-b namespace
- modify cluster-wide resources
- access platform namespaces

---

# Network Policies

Network policies prevent communication between namespaces unless explicitly allowed.

Example policy:

- deny all cross-namespace traffic
- allow traffic only through ingress gateway

This prevents lateral movement between tenants.

---

# Resource Quotas

Resource quotas ensure fair resource allocation between teams.

Example limits:

team-a namespace

pods: 50
cpu: 20 cores
memory: 40Gi

This prevents a single tenant from exhausting cluster resources.

---

# IAM Isolation (IRSA)

AWS IAM Roles for Service Accounts (IRSA) allow pods to access AWS services securely.

Each tenant namespace has service accounts mapped to specific IAM roles.

Example permissions:

team-a workloads:

- access team-a S3 bucket
- read team-a secrets
- connect to team-a database

They cannot access resources belonging to other tenants.

---

# Service Mesh Isolation

The service mesh provides additional traffic control and security.

Capabilities include:

- mTLS between services
- traffic routing policies
- rate limiting
- observability

Traffic between services can be restricted at the mesh level.

---

# Observability Isolation

Monitoring data includes tenant identifiers such as:

tenant.id
namespace
service.name

This allows dashboards and alerts to be filtered per tenant.

Example:

New Relic dashboards can display metrics for:

team-a services
team-b services

independently.

---

# Security Benefits

The multi-layer isolation model provides:

- strong tenant separation
- protection against lateral movement
- secure AWS resource access
- fair resource allocation

This design allows multiple teams to safely share a single platform while maintaining operational boundaries.