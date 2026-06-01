# Acción Pendiente: Vault Secrets Management

## Estado
Pendiente de implementación.

## Prioridad
🟢 P1 - FASE 1: MVP DevOps

## Objetivo
Centralizar y encriptar los secretos de aplicación (BD passwords, JWT secrets, API keys) en HashiCorp Vault en lugar de variables de entorno sin cifrar.

## Componentes
- **Spring Cloud Config Server** (opcional pero recomendado)
- **HashiCorp Vault**
- **spring-cloud-starter-vault-config**
- **Vault KV v2 secrets engine**

## Alcance de implementación
1. Agregar dependencia `spring-cloud-starter-vault-config` al `pom.xml`
2. Configurar propiedades de conexión a Vault en `bootstrap.yaml`
3. Crear estructura de secrets en Vault:
   - `secret/data/galactic-tournament/db-password`
   - `secret/data/galactic-tournament/jwt-secret`
   - `secret/data/galactic-tournament/oidc-credentials`
4. Modificar `application.yaml` para referenciar secrets desde Vault
5. Resolver secretos automáticamente al arranque sin log de valores
6. Crear script de inicialización de Vault en `docker-compose.yaml`
7. Documentar política de rotación de secretos

## Configuración en bootstrap.yaml
```yaml
spring:
  cloud:
    vault:
      host: localhost
      port: 8200
      scheme: http
      token: ${VAULT_TOKEN:dev-token}
      kv-version: 2
      generic:
        path: secret/galactic-tournament
        default-context: application
```

## Secrets a administrar
- `db.password` → PostgreSQL
- `security.jwt.secret` → Token signing
- `cors.allowed-origins` → CORS policy
- `oidc.client-secret` → Keycloak client

## Archivo de referencia
- Instrucciones: `.github/copilot-instructions.md` sección 6 (Secrets Management)
- Análisis previo: `docs/reports/IMPLEMENTATION_SUMMARY.md` sección 5.2

## Notas
- Vault puerto 8200
- En desarrollo: token sin autenticación (token estático)
- En producción: usar AppRole, JWT, o Kubernetes auth

