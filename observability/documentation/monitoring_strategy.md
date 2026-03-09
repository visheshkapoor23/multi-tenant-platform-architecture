# Monitoring Strategy

## Overview

The platform observability stack is implemented using **OpenTelemetry and New Relic** to provide comprehensive monitoring for infrastructure, applications, and CI/CD pipelines.

The monitoring system collects telemetry from multiple layers of the platform and exports it to New Relic for analysis, visualization, and alerting.

The observability stack enables platform engineers and development teams to monitor:

- infrastructure health
- application performance
- deployment pipelines
- tenant-specific metrics

---

# Observability Architecture

Telemetry is collected using the following architecture:

Application / Platform Services  
↓  
OpenTelemetry SDK  
↓  
OpenTelemetry Collector  
↓  
OTLP Exporter  
↓  
New Relic  
↓  
Dashboards, Alerts, and Analytics

OpenTelemetry collectors run inside the Kubernetes cluster and aggregate telemetry from workloads, infrastructure, and services before exporting it to New Relic.

---

# Telemetry Signals

The observability platform collects three primary telemetry signals.

## Metrics

Metrics provide time-series data for monitoring system health and performance.

Examples include:

- CPU utilization
- memory usage
- pod restart counts
- request latency
- request throughput

These metrics are used to build dashboards and generate alerts.

---

## Distributed Traces

Distributed tracing enables end-to-end visibility into application requests across microservices.

Tracing helps identify:

- latency bottlenecks
- slow service dependencies
- failure points in request flows

Example trace attributes:

- service.name
- operation.name
- request.duration
- error.status

---

## Logs

Application and infrastructure logs are collected through the OpenTelemetry pipeline and exported to New Relic.

Logs allow engineers to investigate failures and understand runtime behavior.

---

# Platform Metrics

The platform collects metrics from Kubernetes infrastructure and application workloads.

## Kubernetes Infrastructure Metrics

Collected using the OpenTelemetry collector and kubelet metrics.

Examples:

- node CPU utilization
- node memory usage
- pod restart counts
- pending pods
- container resource limits
- cluster capacity utilization

These metrics provide visibility into cluster health and resource utilization.

---

## Application Performance Metrics

Applications emit telemetry using OpenTelemetry SDKs.

Examples:

- request rate
- request latency (p50, p95, p99)
- error rate
- dependency latency

These metrics enable monitoring of application performance and reliability.

---

## CI/CD Pipeline Metrics

CI/CD pipelines generate telemetry related to build and deployment performance.

Examples:

- build duration
- pipeline execution time
- deployment success rate
- pipeline failure rate
- lead time for changes

These metrics allow platform engineers to monitor the efficiency of the delivery pipeline.

---

# Key Platform SLIs

The following Service Level Indicators (SLIs) are used to measure platform reliability.

| SLI | Description |
|-----|-------------|
| API availability | Percentage of successful requests |
| Request latency | Time taken to serve requests |
| Error rate | Percentage of failed requests |
| Deployment success rate | Successful deployments vs failures |
| Cluster utilization | CPU and memory usage across nodes |

---

# Example SLO Targets

Example Service Level Objectives used by the platform:

| SLO | Target |
|-----|--------|
| API Availability | 99.9% |
| Deployment Success Rate | >95% |
| p95 Request Latency | <300 ms |
| Cluster CPU Utilization | <80% |

SLO violations trigger alerts for platform operators.

---

# Tenant Observability

Because the platform supports multiple engineering teams, observability must provide **tenant-level visibility**.

Telemetry emitted from workloads includes tenant-specific attributes.

Example attributes:

tenant.id  
k8s.namespace.name  
service.name  
environment  

These attributes allow metrics and traces to be filtered per tenant.

Example query:

SELECT average(duration)  
FROM Transaction  
WHERE tenant.id = 'team-a'

This enables teams to monitor only their own workloads while still sharing the same cluster.

---

# Dashboards

Dashboards provide visibility into the platform using New Relic.

Example dashboards include:

## Cluster Health Dashboard

Metrics visualized:

- node CPU utilization
- node memory utilization
- pod restart counts
- pending pods

---

## Application Performance Dashboard

Metrics visualized:

- request rate
- request latency (p95)
- error rate
- dependency latency

---

## CI/CD Pipeline Dashboard

Metrics visualized:

- pipeline execution duration
- deployment frequency
- pipeline failure rate

---

## Tenant Monitoring Dashboard

Allows filtering metrics by:

- tenant.id
- namespace
- service.name

This enables each engineering team to monitor their own services.

---

# Alerting Strategy

Alerts are configured in New Relic based on SLI thresholds.

Examples:

- high error rate alerts
- high latency alerts
- cluster resource saturation
- pod crash loops

Alerts notify platform operators through integrated notification channels.

---

# Benefits of the Observability Strategy

This observability approach provides:

- end-to-end visibility across services
- tenant-specific monitoring
- centralized telemetry collection
- scalable monitoring architecture
- proactive alerting and incident detection

The combination of OpenTelemetry and New Relic enables a scalable monitoring solution for a multi-tenant Kubernetes platform.