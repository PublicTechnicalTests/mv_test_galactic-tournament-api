# Multi-stage Build Dockerfile for Galactic Tournament API
# Stage 1: Build
FROM eclipse-temurin:25-jdk as builder

WORKDIR /build

# Copy Maven wrapper and pom.xml
COPY mvnw ./
COPY mvnw.cmd ./
COPY pom.xml ./
COPY .mvn ./.mvn

# Copy source code
COPY src ./src

# Build application with Maven (skip tests in Docker to save time)
RUN ./mvnw clean package -DskipTests -B -q

# Stage 2: Runtime
FROM eclipse-temurin:25-jre

LABEL maintainer="dev@technicaltests.com"
LABEL description="Galactic Tournament API - Tournament management microservice"
LABEL version="0.1.0"

# Create non-root user for security
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Set working directory
WORKDIR /app

# Copy built application from builder stage
COPY --from=builder /build/target/*.jar app.jar

# Create logs directory
RUN mkdir -p /app/logs && \
    chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD java -cp app.jar org.springframework.boot.loader.JarLauncher || exit 1

# Set JVM options for production
ENV JAVA_OPTS="-XX:+UseG1GC \
    -XX:MaxGCPauseMillis=200 \
    -XX:+HeapDumpOnOutOfMemoryError \
    -XX:HeapDumpPath=/app/logs/heapdump.hprof \
    -Dfile.encoding=UTF-8 \
    -Dspring.profiles.active=production"

# Run application
ENTRYPOINT ["java", "-jar", "app.jar"]

