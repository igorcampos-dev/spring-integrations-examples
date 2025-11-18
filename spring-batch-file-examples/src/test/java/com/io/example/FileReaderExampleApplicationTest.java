package com.io.example;

import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class FileReaderExampleApplicationTest {

    @Test
    void contextLoads() {
    }

    @Test
    void main_shouldCallSpringApplicationRun() {
        try (MockedStatic<SpringApplication> mocked = Mockito.mockStatic(SpringApplication.class)) {
            String[] args = {};
            FileReaderExampleApplication.main(args);
            mocked.verify(() -> SpringApplication.run(FileReaderExampleApplication.class, args));
        }
    }

}
