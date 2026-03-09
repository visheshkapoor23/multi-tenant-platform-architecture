# AWS Cost Estimation (eu-central-1)

## Overview

This document provides an estimated monthly cost for running the multi-tenant platform in the **AWS eu-central-1 region (Frankfurt)**.

The platform is designed to support:

- 20+ engineering teams
- approximately 250 engineers
- scalable to 50+ teams

Costs are estimated based on a **baseline production platform deployment**.

---

# Core Infrastructure Costs

## Amazon EKS Control Plane

EKS control plane pricing:

$0.10 per hour

Monthly cost:

$0.10 × 24 × 30 = **~$72 / month**

---

## Worker Nodes

Assumption:

6 nodes initially

Instance type:

t3.large

Price (eu-central-1):

~$0.0832 per hour

Monthly cost per node:

$0.0832 × 24 × 30 = ~$60

Total worker nodes cost:

6 × $60 = **~$360 / month**

Worker nodes will scale automatically using the **cluster autoscaler**.

---

## NAT Gateway

Private subnets require NAT for outbound traffic.

Price:

~$0.052 per hour

Monthly cost:

$0.052 × 24 × 30 = **~$37 / month**

Additional data processing charges may apply.

---

## Application Load Balancer

Ingress traffic is handled using ALB.

Estimated cost:

**~$25–$50 / month**

depending on traffic volume.

---

# Storage Costs

## Amazon RDS

Example configuration:

db.t3.medium

Estimated monthly cost:

**~$100 – $150**

Includes:

- Multi-AZ deployment
- automated backups

---

## Amazon S3

Used for:

- artifact storage
- backups
- logs

Estimated monthly storage:

100 GB

Estimated cost:

**~$3 – $10 / month**

---

# Observability Costs

Observability includes:

- OpenTelemetry collectors
- New Relic monitoring

Estimated cost depends on ingestion volume.

Typical estimate:

**~$200 – $500 / month**

---

# Total Estimated Monthly Cost

Estimated baseline platform cost:

| Component | Estimated Cost |
|----------|---------------|
| EKS Control Plane | $72 |
| Worker Nodes | $360 |
| NAT Gateway | $37 |
| Load Balancer | $40 |
| RDS Database | $120 |
| S3 Storage | $10 |
| Observability | $300 |

Estimated monthly total:

**~$900 – $1000**

---

# Scaling Cost (50+ Teams)

As the platform grows, additional costs will include:

- more worker nodes
- increased storage
- higher observability ingestion
- additional load balancers

Estimated cost at larger scale:

**~$2000 – $3000 / month**

---

# Cost Optimization Strategies

Several strategies can reduce operational costs:

### Spot Instances

Worker nodes can partially run on **EC2 Spot Instances**, reducing compute cost by up to 70%.

### Cluster Autoscaling

Nodes scale automatically based on demand, preventing over-provisioning.

### Storage Lifecycle Policies

S3 lifecycle policies can move older data to **S3 Glacier**.

### Resource Quotas

Tenant resource quotas prevent inefficient resource consumption.

---

# Conclusion

The estimated cost for running the platform is approximately **$900–$1000 per month for the baseline environment**, with expected scaling to **$2000–$3000 per month** as the number of teams increases.

This architecture balances scalability, reliability, and cost efficiency while supporting a large engineering organization.