# Acción Pendiente: Distributed Tracing (OpenTelemetry + Jaeger)

## Estado
Pendiente de implementación.

## Prioridad
🟢 P1 - FASE 1: MVP DevOps

## Objetivo
Integrar trazabilidad distribuida end-to-end en la aplicación para seguimiento de solicitudes entre servicios en arquitecturas multi-servicio.

## Componentes
- **Spring Cloud Sleuth** (explícito en la configuración, no solo `optional`)
- **OpenTelemetry SDK** como alternativa moderna
- **Jaeger** como backend de tracing distribuido
- **MDC (Mapped Diagnostic Context)** para correlación de logs

## Alcance de implementación
1. Agregar dependencias de OpenTelemetry y Jaeger al `pom.xml`
2. Configurar exportador Jaeger en `src/main/resources/application.yaml`
3. Habilitar propagación de contexto en traces
4. Validar con flujo de test end-to-end A → B → C

## Archivo de referencia
- Instrucciones: `.github/copilot-instructions.md` sección 7 (Logging & Observability)
- Análisis previo: `docs/reports/IMPLEMENTATION_SUMMARY.md` sección 2.1

## Notas
- La aplicación actual usa SLF4J + MDC; esta adición es compatibilidad hacia adelante
- Opcional: docker-compose.yaml actualizado para incluir servicio Jaeger

