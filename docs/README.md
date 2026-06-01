# Documentación del proyecto

Este directorio centraliza toda la documentación del repositorio, organizada por propósito para evitar archivos `.md` dispersos en la raíz.

## Estructura recomendada

- `docs/overview/README.md` → portada general del proyecto
- `docs/changelog/CHANGELOG.md` → historial de cambios
- `docs/deployment/DEPLOYMENT.md` → guía de despliegue y operación
- `docs/guides/HELP.md` → ayuda rápida y referencia práctica
- `docs/analysis/README_IMPROVEMENTS.md` → análisis y resumen de mejoras
- `docs/reports/IMPLEMENTATION_SUMMARY.md` → resumen ejecutivo de implementación
- `docs/reports/TASK_COMPLETION_SUMMARY.md` → cierre y métricas de entrega
- `docs/porMejorar/plan-pendiente-flyway.md` → acción pendiente priorizada

## Categorías

- `docs/overview/` → descripción general del proyecto
- `docs/changelog/` → historial de cambios
- `docs/deployment/` → guías de despliegue y operación
- `docs/guides/` → ayudas rápidas y manuales de uso
- `docs/analysis/` → análisis, resúmenes y material de evaluación
- `docs/reports/` → reportes de implementación y cierre
- `docs/porMejorar/` → acciones pendientes y planes de mejora

## Criterio de categorización

Cada documento debe ubicarse según su objetivo principal:

- Si describe el proyecto: `overview`
- Si registra versiones o cambios: `changelog`
- Si explica cómo ejecutar o desplegar: `deployment`
- Si sirve como ayuda operativa: `guides`
- Si resume hallazgos o comparativas: `analysis`
- Si documenta ejecución o cierre de tareas: `reports`
- Si contiene trabajo pendiente: `porMejorar`

## Regla para nuevas generaciones

Cualquier documentación, resumen o guía generada en futuras iteraciones debe almacenarse dentro de `docs/` y en la subcarpeta que corresponda a su categoría, en lugar de dejarse en la raíz del repositorio.

### Excepción operativa

El archivo `.github/copilot-instructions.md` se conserva en `.github/` porque es una configuración operativa consumida directamente por GitHub Copilot; no se trata como documentación pública del proyecto.


