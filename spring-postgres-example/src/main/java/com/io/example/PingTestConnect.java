package com.io.example;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class PingTestConnect implements CommandLineRunner {

    private final JdbcTemplate jdbcTemplate;

    @Override
    public void run(String... args) {
        String version = jdbcTemplate.queryForObject(
                "SELECT version()",
                String.class
        );

        log.info("Connected to the database!");
        log.info("Postgres database version: {}", version);
    }

}
