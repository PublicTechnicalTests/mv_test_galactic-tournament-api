package com.technicaltests.mv.galactictournament;

import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;
import org.testcontainers.utility.DockerImageName;

/**
 * Abstract base class for Spring Boot integration tests requiring a real PostgreSQL database.
 *
 * <p>Extend this class in any {@code @SpringBootTest} integration test:
 * <pre>{@code
 * @SpringBootTest
 * class MyServiceIntegrationTest extends AbstractIntegrationTest {
 *     // tests run against a real PostgreSQL Testcontainer
 * }
 * }</pre>
 *
 * <p>A single PostgreSQL container is shared across all subclasses in the same JVM run,
 * reducing startup overhead significantly.
 */
@Testcontainers
public abstract class TestcontainersConfiguration {

    @Container
    static final PostgreSQLContainer<?> POSTGRES =
            new PostgreSQLContainer<>(DockerImageName.parse("postgres:16-alpine"));

    @DynamicPropertySource
    static void overrideDataSourceProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", POSTGRES::getJdbcUrl);
        registry.add("spring.datasource.username", POSTGRES::getUsername);
        registry.add("spring.datasource.password", POSTGRES::getPassword);
    }
}



