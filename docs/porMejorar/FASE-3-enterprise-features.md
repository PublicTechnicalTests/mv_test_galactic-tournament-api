# Acción Pendiente: Fase 3 - Enterprise Features (Roadmap v1.0+)

## Estado
Pendiente de implementación.

## Prioridad
🟡 P2 - Roadmap futuro (v1.0 en adelante)

## Objetivo
Implementar características empresariales una vez que FASE 1 y FASE 2 estén maduras en producción.

---

## 📦 1. Multi-Tenancy Support

### Componentes
- **Row-Level Security (RLS)** en PostgreSQL
- **Tenant context resolver** en Spring Security
- **Tenant identifier** en URLs o headers

### Patrón
Cada usuario ve solo datos de su tenant:
```
GET /api/v1/tournaments?tenant_id=acme-corp
```

### Implementación
- Agregar columna `tenant_id` a todas las entidades
- Filter automático en `@Repository` queries
- Test de aislamiento de datos entre tenants

### Beneficios
- Soporte para SaaS multi-tenant
- Escalado horizontal por tenant

---

## 📦 2. Performance Testing Baseline

### Componentes
- **JMH** (Java Microbenchmark Harness) para unit benchmarks
- **Gatling** o **Apache JMeter** para load testing
- **Baseline metrics** documentadas

### Casos de prueba
- GET /tournaments: target <100ms p99, 1000 req/sec
- POST /tournaments: target <500ms p99, 100 req/sec
- DB query timeout: <5s

### Archivos a crear
- `src/test/java/.../perf/TournamentBenchmark.java`
- `performance/gatling-simulation.scala` (Gatling)
- `docs/guides/PERFORMANCE_BASELINE.md`

### CI/CD Integration
- Ejecutar load test en cada release
- Comparar contra baseline
- Fallar si degradación >10%

---

## 📦 3. Architecture Decision Records (ADR)

### Objetivo
Documentar decisiones arquitectónicas importantes y su contexto para futuras referencias.

### Estructura
```
docs/adr/
├── ADR-001-use-postgresql-over-mongodb.md
├── ADR-002-spring-boot-over-quarkus.md
├── ADR-003-jwt-tokens-over-sessions.md
└── README.md
```

### Template ADR
```markdown
# ADR-NXX: Title

## Status
Accepted / Proposed / Deprecated

## Context
Por qué necesitamos esta decisión...

## Decision
Elegimos X porque...

## Consequences
- Positivo: ...
- Negativo: ...
```

---

## 📦 4. Product Roadmap & Maturity Model

### Objetivo
Comunicar clara y públicamente la visión del producto, versión actual y futuro.

### Versiones
```
v0.1.0 (actual)
├─ Basic Tournament CRUD
├─ PostgreSQL persistence
├─ Swagger API docs

v1.0.0 (Q3 2026)
├─ Event-driven notifications
├─ Multi-tenancy
├─ Prometheus monitoring
└─ K8s deployment ready

v2.0.0 (Q4 2026)
├─ Advanced analytics
├─ GraphQL endpoint
├─ Machine Learning recommendations
└─ Mobile API v2
```

### Archivo
- `docs/overview/PRODUCT_ROADMAP.md`

---

## 📦 5. Log Aggregation (ELK Stack / Loki)

### Componentes
- **ELK:** Elasticsearch (storage) + Logstash (ingestion) + Kibana (UI)
- **Alternativa:** Loki (lightweight) + Grafana

### Arquitectura
```
Application (stdout JSON logs)
  ↓ (Filebeat o Promtail)
Aggregator (Logstash / Loki)
  ↓
Storage (Elasticsearch / Loki)
  ↓
UI (Kibana / Grafana)
```

### Configuración
- Logs JSON con correlationId
- Índice por date: `logs-galactic-2026.06.01`
- Retention: 30 días
- Alertas: error rate > 5%

### Archivos a crear
- `docker-compose-logging.yaml` (ELK o Loki)
- `src/main/resources/logback-spring.xml` (JSON format)
- `docs/guides/LOG_ANALYSIS.md`

---

## 📋 Timeline sugerido

### Roadmap v1.0 (Q3 2026)
1. Multi-Tenancy Support → soporte SaaS completo
2. Performance Baseline → garantías de SLA
3. Log Aggregation → troubleshooting en prod

### Roadmap v2.0 (Q4 2026+)
1. ADR Documentación → historio arquitectónico maduro
2. Product Roadmap Público → comunicación con stakeholders

---

## 📚 Archivos de referencia
- Análisis previo: `docs/reports/IMPLEMENTATION_SUMMARY.md` secciones 3.2, 4.2, 7.1-7.2
- Matriz de prioridad: `docs/reports/IMPLEMENTATION_SUMMARY.md` tabla genérica

---

## 📌 Notas finales

Estas iniciativas de FASE 3 son **opcionales pero recomendadas** para:
- Escala empresarial (multi-tenancy)
- Confiabilidad (testing, monitoreo)
- Sostenibilidad (documentación, ADR)

Cada iniciativa debe evaluarse por valor vs esfuerzo con el equipo antes de ser asignada.

