# Acción Pendiente: Semantic Release Automation

## Estado
Pendiente de implementación.

## Prioridad
🟢 P1 - FASE 1: MVP DevOps

## Objetivo
Automatizar el versionado y release basado en Conventional Commits, eliminando intervención manual en bumping de versiones y creación de releases.

## Componentes
- **semantic-release** (Node.js tool)
- **conventional-commits** (commit message spec)
- **GitHub Actions** (trigger release pipeline)
- Auto-CHANGELOG generation
- Auto-git tagging
- Auto-GitHub Release creation

## Alcance de implementación
1. Instalar `semantic-release` CLI localmente (dev dependency en `package.json` ficticio)
2. Crear `.releaserc.json` en raíz del repo
3. Crear GitHub Actions workflow `.github/workflows/semantic-release.yml`
4. Configurar commit triggers: push a `develop` y `main`
5. Alinear con Conventional Commits en instrucciones
6. Validar flujo: commit → auto-version → auto-tag → auto-release
7. Documentar política de pre-release (alpha, beta, rc)

## Configuración en .releaserc.json
```json
{
  "branches": [
    {"name": "main", "channel": "latest"},
    {"name": "develop", "channel": "develop"},
    {"name": "release/*", "prerelease": "prerelease"}
  ],
  "plugins": [
    "@semantic-release/commit-analyzer",
    "@semantic-release/release-notes-generator",
    "@semantic-release/changelog",
    "@semantic-release/npm",
    ["@semantic-release/git", {
      "message": "chore(release): ${nextRelease.version}\n\n${nextRelease.notes}",
      "assets": ["pom.xml", "CHANGELOG.md"]
    }],
    "@semantic-release/github"
  ]
}
```

## Flujo automatizado
1. Desarrollador hace commit: `feat: Add tournament filtering` en feature branch
2. Merge a `develop` → semantic-release calcula MINOR bump → v0.2.0
3. Merge a `main` → semantic-release crea tag `v0.2.0`, GitHub Release
4. CI/CD detecta tag → construye Docker → publica a registry
5. Artefactos desplegables listos en registry

## Commit types
- `feat:` → MINOR bump (backward compatible)
- `fix:` → PATCH bump (bug fix)
- `BREAKING CHANGE:` → MAJOR bump (breaking API)
- `docs:`, `chore:`, `refactor:` → no version bump

## Archivo de referencia
- Instrucciones: `.github/copilot-instructions.md` sección 10 (Versioning, Tagging & Changelog Management)
- Análisis previo: `docs/reports/IMPLEMENTATION_SUMMARY.md` sección 9.1

## Notas
- Requiere token de GitHub en secrets (acceso a releases)
- Actualiza automáticamente `pom.xml` version (requiere plugin)
- Opcional: integración con Slack notificando releases

