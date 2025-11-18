package com.io.example.init;

import com.io.example.repository.TestEntityRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@ActiveProfiles("test")
class InitIntegrationTest {

    @Autowired
    private Init init;

    @Autowired
    private TestEntityRepository repository;

    @Test
    void run_shouldSaveAllRandomEntities() {
        repository.deleteAll();
        init.run();
        int size = repository.findAll().size();
        assertEquals(10000, size);
    }

}
