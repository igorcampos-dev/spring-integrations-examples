package com.io.example;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.bson.Document;
import org.springframework.boot.CommandLineRunner;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class PingTestConnect implements CommandLineRunner {

    private final MongoTemplate mongoTemplate;

    @Override
    public void run(String... args) {
        String version = mongoTemplate
                .getDb()
                .runCommand(new Document("buildInfo", 1))
                .getString("version");

        log.info("Connected to the database!");
        log.info("Mongo database version: {}", version);
    }

}
