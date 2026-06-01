# Acción Pendiente: OAuth2 Resource Server

## Estado
Pendiente de implementación.

## Prioridad
🟢 P1 - FASE 1: MVP DevOps

## Objetivo
Implementar autenticación/autorización OAuth2 con un proveedor (Keycloak recomendado) para asegurar todos los endpoints de la API.

## Componentes
- **Spring Security OAuth2 Resource Server**
- **Keycloak** (identity provider)
- **JWT tokens** para stateless authentication
- **@PreAuthorize** para autorización basada en roles

## Alcance de implementación
1. Agregar `spring-boot-starter-oauth2-resource-server` al `pom.xml`
2. Configurar propiedades OAuth2 en `application.yaml`
3. Crear `SecurityConfig.java` con `@EnableWebSecurity`
4. Implementar `WebSecurityConfigurerAdapter` (o SecurityFilterChain bean en Spring 6.1+)
5. Marcar endpoints como `@PreAuthorize("hasRole('USER')")`
6. Integrar Keycloak en `docker-compose.yaml`
7. Crear flujo de test: obtener token → llamar endpoint protegido

## Configuración en application.yaml
```yaml
spring:
  security:
    oauth2:
      resourceserver:
        jwt:
          issuer-uri: http://keycloak:8080/realms/galactic-tournament
          jwk-set-uri: http://keycloak:8080/realms/galactic-tournament/protocol/openid-connect/certs
```

## Roles sugeridos
- `TOURNAMENT_ADMIN`: crear/editar torneos
- `TOURNAMENT_USER`: participar en torneos
- `SYSTEM_ADMIN`: acceso a actuator

## Archivo de referencia
- Instrucciones: `.github/copilot-instructions.md` sección 6 (Input Validation & Security Constraints)
- Análisis previo: `docs/reports/IMPLEMENTATION_SUMMARY.md` sección 5.1

## Notas
- Keycloak puerto 8081 (para evitar conflicto con API en 8080)
- JWT valida automáticamente con JWK set publicado por Keycloak

