# New Relic Integration

The platform exports telemetry data from OpenTelemetry collectors to New Relic using the OTLP exporter.

Telemetry collected includes:

- infrastructure metrics
- application metrics
- distributed traces
- logs

## Export Method

The OpenTelemetry collector sends telemetry data to the New Relic OTLP endpoint.

Example configuration:

endpoint: otlp.nr-data.net:4317

The following resource attributes are attached to telemetry data:

- tenant.id
- service.name
- namespace
- environment

These attributes allow dashboards and alerts to be filtered by tenant or service.

## Example Query

Example New Relic query for monitoring application latency:

SELECT percentile(duration,95)
FROM Transaction
TIMESERIES