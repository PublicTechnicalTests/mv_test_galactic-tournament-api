# Acción pendiente: Flyway Database Migrations

## Estado
Pendiente de implementación.

## Alcance acordado
Esta acción pendiente contiene únicamente la iniciativa de **Flyway Database Migrations**.

## Objetivo
Inicializar el control de versiones de la base de datos para que el esquema de PostgreSQL quede administrado por migraciones reproducibles.

## Pasos de inicialización
1. Agregar la dependencia de Flyway al `pom.xml`.
2. Activar la configuración base en `application.yaml`.
3. Crear la carpeta `src/main/resources/db/migration`.
4. Agregar la migración inicial `V1__init.sql`.
5. Validar el arranque de la aplicación con las migraciones aplicadas.

## Observación
No se incluyen aquí otras iniciativas del plan recomendado; el alcance se mantiene deliberadamente acotado a Flyway para evitar saturación de contexto y facilitar la ejecución granular.
