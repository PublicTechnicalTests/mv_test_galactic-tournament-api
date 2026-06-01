# Acción Pendiente: Kubernetes Deployment Manifests

## Estado
Pendiente de implementación.

## Prioridad
🟢 P1 - FASE 1: MVP DevOps

## Objetivo
Crear manifiestos YAML de Kubernetes para desplegar la aplicación en producción con alta disponibilidad, escalabilidad horizontal y observabilidad.

## Componentes
- **Deployment** → control de réplicas y rolling updates
- **Service** → exposición interna/externa
- **ConfigMap** → configuración no sensible
- **Secret** → variables sensibles (Vault-backed)
- **HorizontalPodAutoscaler** → escalado automático
- **PodDisruptionBudget** → garantía de disponibilidad
- **Ingress** → enrutamiento HTTP/HTTPS
- **NetworkPolicy** → zero-trust networking

## Estructura de directorios
```
k8s/
├── base/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── configmap.yaml
│   └── secret.yaml
├── overlays/
│   ├── dev/
│   │   ├── kustomization.yaml
│   │   └── patches/
│   ├── staging/
│   └── prod/
│       ├── kustomization.yaml
│       ├── hpa.yaml
│       ├── pdb.yaml
│       ├── ingress.yaml
│       └── networkpolicy.yaml
└── README.md
```

## Alcance de implementación
1. Crear `k8s/base/deployment.yaml` con estrategia RollingUpdate
2. Crear `k8s/base/service.yaml` ClusterIP + NodePort
3. Crear `k8s/base/configmap.yaml` con properties no sensibles
4. Crear `k8s/overlays/prod/hpa.yaml` (2-10 replicas, 70% CPU)
5. Crear `k8s/overlays/prod/pdb.yaml` (minAvailable: 1)
6. Crear `k8s/overlays/prod/ingress.yaml` con TLS
7. Crear `k8s/overlays/prod/networkpolicy.yaml` (deny all, allow services)
8. Usar **kustomize** para gestionar variantes (dev/staging/prod)

## Health checks en K8s
- `liveness` → `/actuator/health/liveness` (30s delay, 10s timeout)
- `readiness` → `/actuator/health/readiness` (15s delay, 5s timeout)
- `startup` → `/actuator/health/startup` (60s delay, override para DB slow)

## Archivo de referencia
- Instrucciones: `.github/copilot-instructions.md` sección 0 (Deploy phase)
- Análisis previo: `docs/reports/IMPLEMENTATION_SUMMARY.md` sección 6.1

## Notas
- Usar `imagePullPolicy: IfNotPresent` para desarrollo
- Usar `imagePullSecrets` en producción (private registry)
- Montar ConfigMap/Secret como archivos o env vars según caso

