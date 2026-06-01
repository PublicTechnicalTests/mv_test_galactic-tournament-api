# Acción Pendiente: Prometheus Metrics + Grafana

## Estado
Pendiente de implementación.

## Prioridad
🟢 P1 - FASE 1: MVP DevOps

## Objetivo
Integrar métricas de aplicación para monitoreo en tiempo real con Prometheus y visualización en Grafana.

## Componentes
- **Micrometer Prometheus Registry** → exposición de métricas en `/actuator/prometheus`
- **Prometheus** → scraping de métricas cada 15s
- **Grafana** → dashboards de visualización
- **Alertas** → configuración básica de alertas en Grafana

## Alcance de implementación
1. Agregar `micrometer-registry-prometheus` a `pom.xml`
2. Activar `/actuator/prometheus` en `application.yaml`
3. Crear `docker-compose-monitoring.yaml` con Prometheus + Grafana
4. Generar Dockerfile para Prometheus (scrape config)
5. Crear dashboard Grafana básico (JVM, HTTP requests, DB connections)
6. Documentar en `docs/guides/MONITORING.md`

## Métricas prioritarias a exponer
- JVM: heap, GC, threads
- HTTP: requests/min, latency p99, error rate
- Database: connection pool, query time
- Custom: tournament API-specific KPIs

## Archivo de referencia
- Análisis previo: `docs/reports/IMPLEMENTATION_SUMMARY.md` sección 2.2
- Instrucciones: `.github/copilot-instructions.md` sección 7 (Management - endpoints)

## Notas
- Prometheus scrape en puerto 9090
- Grafana en puerto 3000
- Alertas iniciales: high_error_rate, low_uptime

