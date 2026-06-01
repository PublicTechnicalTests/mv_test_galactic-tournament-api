# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **Iteration & DevOps Lifecycle Framework** - Established complete DevOps cycle framework (Plan → Code → Build → Test → Release → Deploy → Monitor)
- **Gitflow Workflow Integration** - Defined branch strategy with `main`, `develop`, `feature/*`, `release/*`, `hotfix/*`
- **Definition of Done (DoD)** - Comprehensive checklist for each iteration covering code quality, testing, security, and documentation
- **Maven Artifact & Versioning Strategy** - Defined GroupId, ArtifactId, version format (SemVer), and repository configuration
- **Layered Architecture** - Structured project with Controllers → Services → Repositories → DTOs separation
- **SOLID Principles** - Mandatory enforcement of Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, and Dependency Inversion principles
- **Code Coverage Enforcement** - JaCoCo plugin configured with 80% minimum line/instruction coverage check
- **Integration Testing** - Testcontainers support for PostgreSQL integration tests
- **OpenAPI/Swagger Documentation** - Added springdoc-openapi-starter-webmvc-ui for automatic API documentation
- **Security Scanning** - OWASP Dependency-Check plugin integrated into build pipeline
- **Input Validation** - Spring Boot Validation framework with centralized `@ControllerAdvice` exception handling
- **Logging & Observability** - Spring Boot Actuator + SLF4J with structured logging and correlation IDs (MDC)
- **CI/CD Pipeline** - Complete GitHub Actions workflow stages (Init, Build & Test, Coverage Gate, Security Checks, Container Build)
- **Conventional Commits** - Established commit message format for semantic versioning automation
- **pom.xml Enhancements**:
  - Updated ArtifactId to `galactic-tournament-api` (kebab-case)
  - Configured Java 25 compiler settings with explicit `<release>25</release>`
  - Added project metadata (name, description, URL, licenses, developers, SCM)
  - Included springdoc-openapi-starter-webmvc-ui for Swagger/OpenAPI support
  - Added Testcontainers dependencies (testcontainers, postgresql, junit-jupiter)
  - Configured JaCoCo plugin with 80% coverage checking
  - Integrated OWASP Dependency-Check Maven plugin
  - Added Maven Surefire plugin for test execution with proper includes

### Changed
- **version** - Bumped from `0.0.1-SNAPSHOT` to `0.1.0-SNAPSHOT` for initial development branch
- **pom.xml structure** - Reorganized and commented dependencies by category (Production, Testing, Development)
- **Spring Boot Starters** - Corrected invalid starters (replaced non-existent ones with standard Spring Boot starters)
- **maven-compiler-plugin** - Upgraded to v3.13.0 with explicit Java 25 configuration

### Fixed
- Fixed invalid Spring Boot test starters in pom.xml (some starters don't exist in Spring Boot)
- Corrected ArtifactId naming convention (was `GalacticTournament`, now `galactic-tournament-api`)

### Security
- Configured OWASP Dependency-Check to fail on CVEs with CVSS score ≥ 7.0
- Established secrets management guidelines (never commit to Git)
- Defined security headers configuration (X-Content-Type-Options, X-Frame-Options, HSTS, CSP)
- Added SQL injection prevention guidelines (parameterized queries only)
- Implemented CORS security constraints (explicit origins only)

### Documentation
- **Copilot Instructions Updated** - Comprehensive 11-section guide covering:
  - Tech stack specifications (Java 25, Spring Boot 4.1.0.SNAPSHOT)
  - Gitflow workflow requirements
  - Design and quality standards (SOLID, Clean Code)
  - Testing & code coverage (80% minimum)
  - Input validation & security constraints
  - Logging & observability patterns
  - OpenAPI/Swagger documentation standards
  - CI/CD pipeline automation (GitHub Actions)
  - Versioning, tagging & changelog management
  - Dependency management & security scanning
  - Output formatting requirements

## [0.1.0] - 2026-06-01

### Added
- Initial project setup with Spring Boot 4.1.0.SNAPSHOT
- Java 25 configuration
- PostgreSQL support with Spring Data JPA
- Spring Security integration
- Spring Validation framework
- Development and testing infrastructure
- Initial pom.xml with core dependencies

---

**Installation Notes:**
- Requires Maven 3.8.9+ (enforces HTTPS)
- JDK 25 (Eclipse Temurin recommended)
- PostgreSQL 15+ (via Docker Compose)

**Running Locally:**
```bash
# Build and verify with full test suite + coverage check
mvn clean verify

# Run application
mvn spring-boot:run

# Run integration tests with Testcontainers
mvn verify -Dtest=*IntegrationTest

# Generate Swagger UI
# Navigate to: http://localhost:8080/swagger-ui.html
```

