package com.technicaltests.mv.galactictournament;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * Integration test that verifies the full Spring application context
 * loads successfully against a real PostgreSQL instance (via Testcontainers).
 *
 * <p>Extends {@link TestcontainersConfiguration} to inherit the shared PostgreSQL
 * container and its dynamic datasource property overrides.
 */
@SpringBootTest
class GalacticTournamentApplicationTests extends TestcontainersConfiguration {

    @Test
    @DisplayName("Spring application context loads successfully with PostgreSQL container")
    void contextLoads() {
        // Validates that all beans are wired correctly and Flyway migrations run
    }
}
