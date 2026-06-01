# Acción Pendiente: Circuit Breaker Pattern

## Estado
Pendiente de implementación.

## Prioridad
🟢 P1 - FASE 1: MVP DevOps

## Objetivo
Implementar el patrón Circuit Breaker para prevenir cascadas de fallos cuando servicios externos o dependencias internas fallan o responden lentamente.

## Componentes
- **Resilience4j** → library ligera de patrones resiliencia
- **@CircuitBreaker** → anotación de Spring Cloud
- **Retry** policy → reintentos exponenciales
- **TimeLimiter** → timeout para llamadas largas
- **Fallback** methods → degradación graciosa

## Alcance de implementación
1. Agregar `spring-cloud-starter-circuitbreaker-resilience4j` al `pom.xml`
2. Configurar Resilience4j en `application.yaml`
3. Identificar llamadas externas críticas (ej: servicio de pagos, DB)
4. Decorar métodos de servicios con `@CircuitBreaker`, `@Retry`, `@TimeLimiter`
5. Implementar métodos fallback para degradación
6. Crear tests de resiliencia (inyectar fallos, validar circuit abierto)
7. Exponer métricas de circuit breaker en `/actuator/metrics`

## Configuración en application.yaml
```yaml
resilience4j:
  circuitbreaker:
    instances:
      externalPaymentApi:
        register-health-indicator: true
        failure-rate-threshold: 50
        slow-call-rate-threshold: 50
        slow-call-duration-threshold: 2000
        wait-duration-in-open-state: 10000
        permitted-number-of-calls-in-half-open-state: 3
  retry:
    instances:
      externalPaymentApi:
        max-attempts: 3
        wait-duration: 1000
        retry-exceptions:
          - java.io.IOException
  timelimiter:
    instances:
      externalPaymentApi:
        timeout-duration: 5s
```

## Ejemplo de implementación
```java
@Service
public class ExternalPaymentService {
  @CircuitBreaker(name = "externalPaymentApi", fallbackMethod = "fallback")
  @Retry(name = "externalPaymentApi")
  @TimeLimiter(name = "externalPaymentApi")
  public ResponseEntity<Payment> processPayment(PaymentRequest req) {
    return restTemplate.postForEntity("https://payment-api.com/process", req, Payment.class);
  }
  
  public ResponseEntity<Payment> fallback(PaymentRequest req, Exception ex) {
    log.warn("Payment service unavailable; using fallback", ex);
    return ResponseEntity.status(503).build();
  }
}
```

## Archivo de referencia
- Instrucciones: `.github/copilot-instructions.md` sección 0 (Resilience patterns)
- Análisis previo: `docs/reports/IMPLEMENTATION_SUMMARY.md` sección 10.1

## Notas
- Estados del circuit: CLOSED (normal) → OPEN (fallando) → HALF_OPEN (prueba)
- Métricas expuestas: `resilience4j.circuitbreaker.*` en Prometheus

