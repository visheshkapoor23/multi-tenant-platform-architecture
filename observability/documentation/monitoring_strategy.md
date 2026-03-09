# Monitoring Strategy

The platform observability stack is implemented using OpenTelemetry and New Relic.

## Observability Architecture

Application workloads emit telemetry through OpenTelemetry SDKs.

Telemetry is collected by the OpenTelemetry Collector deployed inside the Kubernetes cluster.

The collector exports telemetry data to New Relic using OTLP.

Application → OpenTelemetry SDK → Collector → New Relic

## Telemetry Types

The platform collects:

- metrics
- logs
- distributed traces
- CI/CD pipeline metrics
- tenant-level resource metrics

## Platform Metrics

Key platform metrics include:

Cluster metrics
- node CPU utilization
- memory usage
- pod restart rates

Application metrics
- request rate
- error rate
- latency

Pipeline metrics
- build duration
- deployment success rate
- pipeline failures

## Tenant Observability

Each tenant emits telemetry with attributes:

tenant.id  
namespace  
service.name  

This allows monitoring dashboards to filter metrics by engineering team.

## SLIs

Key service level indicators include:

- API availability
- request latency
- deployment success rate
- cluster resource utilization

## SLO Targets

Example SLOs:

API availability: 99.9%

Pipeline success rate: >95%

p95 request latency < 300ms