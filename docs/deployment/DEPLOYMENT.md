# 🚀 Deployment Guide - Galactic Tournament API

## Table of Contents
1. [Local Development Setup](#local-development-setup)
2. [Building the Application](#building-the-application)
3. [Running with Docker Compose](#running-with-docker-compose)
4. [CI/CD Pipeline](#cicd-pipeline)
5. [Production Deployment](#production-deployment)
6. [Monitoring & Health Checks](#monitoring--health-checks)
7. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Required Tools
- **Java 25** (Eclipse Temurin or OpenJDK)
- **Maven 3.8.9+** (HTTPS enforced)
- **Docker & Docker Compose** (v20.10+)
- **Git** (for version control)
- **PostgreSQL 16+** (if running without Docker)

### Verify Installation
```powershell
java -version
mvn --version
docker --version
docker-compose --version
git --version
```

---

## Local Development Setup

### 1. Clone Repository
```powershell
git clone https://github.com/technicaltests/mv_test_galactic-tournament-api.git
cd mv_test_galactic-tournament-api
```

### 2. Create Feature Branch (Gitflow)
```powershell
git checkout develop
git pull origin develop
git checkout -b feature/GT-XXX-description
```

### 3. Set Environment Variables (Windows PowerShell)
```powershell
$env:DB_PASSWORD = "tournament_password"
$env:SECURITY_USER = "admin"
$env:SECURITY_PASSWORD = "admin"
$env:JWT_SECRET = "your-dev-secret-key"
```

### 4. Verify PostgreSQL Connection
Ensure PostgreSQL is running on `localhost:5432` or use Docker Compose:
```powershell
docker-compose up -d postgres
```

---

## Building the Application

### Full Build with Tests & Coverage Check
```powershell
# Complete DevOps cycle: compile, test, coverage verification
mvn clean verify

# Output expectations:
# ✅ BUILD SUCCESS
# ✅ All tests pass
# ✅ JaCoCo coverage >= 80%
```

### Build Without Tests (for Quick Iteration)
```powershell
mvn clean package -DskipTests
```

### Build with Specific Java Compiler
```powershell
mvn clean verify -Dcompiler.release=25
```

### Generate OpenAPI/Swagger Documentation
```powershell
mvn clean verify
# Swagger UI available at: http://localhost:8080/swagger-ui.html
# OpenAPI YAML: http://localhost:8080/v3/api-docs.yaml
```

### Check Code Coverage
```powershell
# JaCoCo report location
# .\target\site\jacoco\index.html

# View coverage metrics
mvn jacoco:report
Start-Process ".\target\site\jacoco\index.html"
```

### Run OWASP Dependency Check
```powershell
# Security vulnerability scanning
mvn dependency-check:check

# View report
Start-Process ".\target\dependency-check-report.html"
```

---

## Running with Docker Compose

### Option 1: Build Locally and Run
```powershell
# Build JAR first
mvn clean package -DskipTests

# Start all services (PostgreSQL + API)
docker-compose up --build

# Alternative: Detached mode (background)
docker-compose up -d
```

### Option 2: Clean Start (Remove Previous Volumes)
```powershell
# Remove all containers and volumes
docker-compose down -v

# Rebuild and start
docker-compose up --build
```

### Verify Services Running
```powershell
# Check container status
docker-compose ps

# View logs
docker-compose logs -f galactic-tournament-api
docker-compose logs -f postgres

# Test API health
Invoke-WebRequest -Uri http://localhost:8080/actuator/health

# Test Swagger UI
# Open browser: http://localhost:8080/swagger-ui.html
```

### Access Services
| Service | URL | Credentials |
|---------|-----|-------------|
| Swagger UI | http://localhost:8080/swagger-ui.html | - |
| Actuator | http://localhost:8080/actuator | - |
| Health Check | http://localhost:8080/actuator/health | - |
| Metrics | http://localhost:8080/actuator/metrics | - |
| PostgreSQL | localhost:5432 | user: tournament_user / password: tournament_password |

### Environment Variables Override
```powershell
# Override PostgreSQL credentials
docker-compose -e DB_PASSWORD=newpassword up

# OR create .env file
@"
DB_PASSWORD=tournament_password
SECURITY_USER=admin
SECURITY_PASSWORD=admin
JWT_SECRET=your-secret-key
CORS_ALLOWED_ORIGINS=http://localhost:3000,http://localhost:4200
"@ | Out-File .env

# Use .env file
docker-compose up
```

### Stop Services
```powershell
docker-compose down

# Stop and remove volumes (data cleanup)
docker-compose down -v
```

---

## CI/CD Pipeline

### GitHub Actions Workflow
Located at: `../../.github/workflows/ci-cd.yml`

### Workflow Stages
1. **Build & Test Phase**
   - Checkout code
   - Setup Java 25 (Temurin)
   - Run `mvn clean verify` (tests + coverage)
   - Coverage gate: fails if < 80%

2. **Security Scanning Phase**
   - OWASP Dependency-Check
   - Fails on CVSS >= 7.0

3. **Container Build Phase**
   - Multi-stage Docker build
   - Tags with commit SHA and version
   - Caches build layers

4. **Status Check Phase**
   - Validates all previous stages
   - Posts results to PR comments

### Manual Workflow Trigger (GitHub UI)
1. Go to **Actions** tab
2. Select **CI/CD Pipeline**
3. Click **Run workflow**
4. Select branch (main/develop/feature/*)

### View Workflow Results
- GitHub Actions logs: **Actions** tab → **CI/CD Pipeline** → click run
- Coverage reports: Artifacts section
- Security reports: Artifacts section

---

## Production Deployment

### 1. Release Branch Creation (Semantic Versioning)
```powershell
# Current version: 0.1.0-SNAPSHOT

# Create release branch
git checkout develop
git checkout -b release/v0.1.0

# Update pom.xml version
# Change: <version>0.1.0-SNAPSHOT</version>
# To: <version>0.1.0</version>
mvn versions:set -DnewVersion=0.1.0

# Update `../../docs/changelog/CHANGELOG.md`
# Move [Unreleased] section to `../../docs/changelog/CHANGELOG.md` -> [0.1.0] - 2026-06-01

# Commit release
git add pom.xml docs/changelog/CHANGELOG.md
git commit -m "release(0.1.0): Prepare release 0.1.0"

# Push to GitHub
git push origin release/v0.1.0
```

### 2. Create Pull Request to main
```powershell
# PR: release/v0.1.0 -> main
# Status checks MUST pass (CI/CD)
# Require code review (at least 1 approver)
# After approval, merge with commit message:
# "Merge release/v0.1.0 into main (release 0.1.0)"
```

### 3. Tag Release
```powershell
git checkout main
git pull origin main

# Create annotated tag
git tag -a v0.1.0 -m "Release version 0.1.0 - Tournament API"

# Push tag
git push origin v0.1.0

# GitHub automatically creates Release from tag
```

### 4. Build & Push Docker Image (Manual or via CI/CD)
```powershell
# Build image locally
docker build -t galactic-tournament-api:0.1.0 .
docker build -t galactic-tournament-api:latest .

# Tag for registry
docker tag galactic-tournament-api:0.1.0 myregistry.azurecr.io/galactic-tournament-api:0.1.0
docker tag galactic-tournament-api:latest myregistry.azurecr.io/galactic-tournament-api:latest

# Push to container registry
docker push myregistry.azurecr.io/galactic-tournament-api:0.1.0
docker push myregistry.azurecr.io/galactic-tournament-api:latest
```

### 5. Deploy to Production

#### Azure Container Apps (Example)
```powershell
# Login to Azure
az login

# Create or update deployment
az containerapp up `
  --name galactic-tournament-api `
  --resource-group galactic-prod `
  --location eastus `
  --image myregistry.azurecr.io/galactic-tournament-api:0.1.0 `
  --registry-server myregistry.azurecr.io `
  --registry-username <username> `
  --registry-password <password> `
  --target-port 8080 `
  --ingress external `
  --query properties.configuration.ingress.fqdn
```

#### Kubernetes (Example with helm)
```powershell
helm upgrade --install galactic-tournament-api ./helm/galactic-tournament-api `
  --namespace production `
  --values ./helm/values-prod.yaml `
  --set image.tag=0.1.0
```

---

## Monitoring & Health Checks

### Health Check Endpoints
```powershell
# Overall health
curl http://localhost:8080/actuator/health

# Detailed health (requires authentication)
curl http://localhost:8080/actuator/health/details

# Liveness probe (K8s)
curl http://localhost:8080/actuator/health/liveness

# Readiness probe (K8s)
curl http://localhost:8080/actuator/health/readiness
```

### Metrics Endpoints
```powershell
# All available metrics
curl http://localhost:8080/actuator/metrics

# Specific metrics
curl http://localhost:8080/actuator/metrics/jvm.memory.used
curl http://localhost:8080/actuator/metrics/http.server.requests
curl http://localhost:8080/actuator/metrics/process.cpu.usage
```

### View Application Logs
```powershell
# Docker logs (real-time)
docker-compose logs -f galactic-tournament-api

# Local file logs
Get-Content "./logs/galactic-tournament-api.log" -Tail 100

# Filter by log level
Select-String "ERROR|WARN" "./logs/galactic-tournament-api.log"
```

### Monitoring Dashboard (Optional - Prometheus)
```powershell
# Prometheus scrape endpoint
http://localhost:8080/actuator/prometheus

# Can be scraped by Prometheus for grafana visualization
```

---

## Troubleshooting

### Issue: Maven Build Fails

**Symptom**: `mvn clean verify` fails with dependency error
```powershell
# Solution 1: Clear Maven cache
mvn clean -DskipTests
rm -r ~/.m2/repository

# Solution 2: Update snapshots
mvn clean verify -U

# Solution 3: Check network connectivity
Test-NetConnection -ComputerName repo.spring.io -Port 443
```

### Issue: PostgreSQL Connection Timeout

**Symptom**: Application fails to connect to database
```powershell
# Solution 1: Verify PostgreSQL is running
docker-compose ps

# Solution 2: Check database credentials in `../../src/main/resources/application.yaml`
# Default: tournament_user / tournament_password

# Solution 3: Test connection
docker exec galactic-tournament-db psql -U tournament_user -d galactic_tournament -c "SELECT 1"

# Solution 4: Restart PostgreSQL
docker-compose restart postgres
```

### Issue: JaCoCo Coverage Below 80%

**Symptom**: Build fails on coverage gate
```powershell
# Generate coverage report
mvn clean verify

# View detailed report
Start-Process ".\target\site\jacoco\index.html"

# Add missing tests in src/test/java directory
# Target: 80%+ line coverage on production code
```

### Issue: OWASP Dependency-Check Fails

**Symptom**: Build fails due to HIGH/CRITICAL CVEs
```powershell
# View dependency-check report
Start-Process ".\target\dependency-check-report.html"

# Options:
# 1. Update vulnerable dependency to patched version
# 2. Suppress known vulnerability (document rationale in pom.xml)
# 3. Use alternative library without CVE

# Update suppression file
# ../../dependency-check-suppressions.xml
```

### Issue: Docker Build Fails

**Symptom**: `docker-compose build` errors
```powershell
# Solution 1: Ensure JAR is built
mvn clean package -DskipTests
docker-compose build --no-cache

# Solution 2: Check Dockerfile syntax
docker build --progress=plain .

# Solution 3: Verify base image availability
docker pull eclipse-temurin:25-jre
```

### Issue: Docker Container Exits Immediately

**Symptom**: `docker-compose up` shows container exiting
```powershell
# View container logs
docker-compose logs galactic-tournament-api

# Common causes:
# - Database connection timeout: Check postgres service health
# - Port 8080 already in use: Change port mapping in `../../compose.yaml`
# - Missing environment variables: Set in .env or docker-compose environment section

# Restart with verbose logging
docker-compose up --no-log-prefix galactic-tournament-api
```

### Debug Mode

Enable verbose logging for development:
```powershell
# Set Spring debug level in `../../src/main/resources/application.yaml`
# logging.level.com.technicaltests.mv: DEBUG

# Or via environment variable
$env:LOGGING_LEVEL_COM_TECHNICALTESTS_MV = "DEBUG"
mvn spring-boot:run
```

---

## Quick Reference Commands

```powershell
# Full local development cycle
git checkout develop
git checkout -b feature/GT-XXX-description
mvn clean verify                          # Build + test + coverage
docker-compose up -d postgres            # Start PostgreSQL
mvn spring-boot:run                      # Start application
# Test at http://localhost:8080/swagger-ui.html

# Release to production
git checkout release/v0.1.0
mvn versions:set -DnewVersion=0.1.0
# Edit `../../docs/changelog/CHANGELOG.md`
git commit -am "release(0.1.0): Prepare release"
git push origin release/v0.1.0
# Create PR -> approve -> merge -> tag

# Production deployment
docker build -t galactic-tournament-api:0.1.0 .
docker tag galactic-tournament-api:0.1.0 registry/galactic-tournament-api:0.1.0
docker push registry/galactic-tournament-api:0.1.0
```

---

## Documentation Links

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [Maven Documentation](https://maven.apache.org/guides/)
- [Docker Documentation](https://docs.docker.com/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Gitflow](https://nvie.com/posts/a-successful-git-branching-model/)
- [Semantic Versioning](https://semver.org/)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

**Last Updated**: 2026-06-01  
**Version**: 0.1.0-SNAPSHOT  
**Maintainer**: dev@technicaltests.com

