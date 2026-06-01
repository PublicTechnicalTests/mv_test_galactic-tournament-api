# Acción Pendiente: Fase 2 - Advanced Patterns (Sprint 3-4)

## Estado
Pendiente de implementación.

## Prioridad
🟡 P2 - Roadmap futuro

## Objetivo
Implementar patrones avanzados de arquitectura una vez que FASE 1 esté estable y funcionando en producción.

---

## 📦 1. Event-Driven Architecture (Apache Kafka)

### Componentes
- **Spring Cloud Stream**
- **Apache Kafka** (broker)
- **Topic partitioning** para escalabilidad
- **Schema Registry** (Avro/Protobuf)

### Caso de uso
Cuando se crea un torneo → evento publicado → notificación enviada, estadística registrada, replicación BD

### Archivos a crear
- `k8s/kafka-operator.yaml` (Strimzi)
- `src/main/java/.../event/TournamentCreatedEvent.java`
- `src/main/java/.../publisher/TournamentEventPublisher.java`
- Tests: `src/test/java/.../TournamentEventPublisherTest.java`

---

## 📦 2. CQRS Pattern (Command Query Responsibility Segregation)

### Componentes
- **Separación Write Model (Commands)** vs **Read Model (Queries)**
- **Event Sourcing** (opcional)
- **Eventually Consistent** eventual consistency

### Caso de uso
Modelo de escritura optimizado para transacciones; modelo de lectura optimizado para queries analíticas

### Archivos a crear
- `src/main/java/.../command/CreateTournamentCommand.java`
- `src/main/java/.../handler/CreateTournamentCommandHandler.java`
- `src/main/java/.../query/TournamentReadModel.java`

---

## 📦 3. Contract Testing (Pact)

### Componentes
- **Pact** (consumer-driven contracts)
- **Pact Broker** (contract repository)
- **Spring Cloud Contract** (producer-side validation)

### Caso de uso
Evitar breaking changes cuando hay múltiples consumidores de la API

### Archivos a crear
- `src/test/java/.../pact/TournamentConsumerPactTest.java` (consumer side)
- CI/CD: Publicar contratos al Pact Broker

---

## 📦 4. Helm Charts for Kubernetes

### Componentes
- **Helm 3**
- **Chart.yaml** (metadata)
- **values.yaml** (defaults)
- **templates/** (manifests templated)

### Directorio a crear
```
helm/galactic-tournament-api/
├── Chart.yaml
├── values.yaml
├── values-prod.yaml
├── templates/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   └── configmap.yaml
└── README.md
```

### Comando de despliegue futuro
```bash
helm upgrade --install galactic-tournament-api ./helm/galactic-tournament-api \
  -f values-prod.yaml \
  --namespace production
```

---

## 📦 5. ArgoCD + GitOps

### Componentes
- **ArgoCD** (continuous delivery)
- **Git como single source of truth**
- **Auto-sync** de cambios en repo → K8s cluster

### Flujo
1. Cambio mergeado a `main` → actualiza `values-prod.yaml` en repo
2. ArgoCD detecta cambio → auto-sync a K8s
3. Sin CD pipeline manual; pull-based en lugar de push-based

### Archivos a crear
- `argocd/app-galactic-tournament.yaml` (ArgoCD Application CR)
- `argocd/project.yaml` (ArgoCD Project: RBAC + allowed namespaces)

---

## 📦 6. SonarQube Code Quality

### Componentes
- **SonarQube** (server)
- **sonar-maven-plugin**
- **Quality Gates** (coverage, duplication, bugs)

### Configuración
```xml
<plugin>
  <groupId>org.sonarsource.scanner.maven</groupId>
  <artifactId>sonar-maven-plugin</artifactId>
  <version>3.11.0.3477</version>
</plugin>
```

### Métricas
- Code Coverage: ≥80%
- Code Duplication: <3%
- Bugs: 0
- Security Hotspots: 0

---

## 📋 Timeline sugerido
- **Sprint 3:** Event-Driven (1) + CQRS (2) → desacoplamiento de servicios
- **Sprint 4:** Helm Charts (4) + ArgoCD (5) → GitOps ready
- **Sprint 5:** Contract Testing (3) + SonarQube (6) → quality gates

---

## 📚 Archivos de referencia
- Análisis previo: `docs/reports/IMPLEMENTATION_SUMMARY.md` secciones 1.1-1.2
- Instrucciones: `.github/copilot-instructions.md` sección 4

