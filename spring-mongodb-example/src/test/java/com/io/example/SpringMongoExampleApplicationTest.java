package com.io.example;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.bean.override.mockito.MockitoBean;

@SpringBootTest
@ActiveProfiles("test")
public class SpringMongoExampleApplicationTest {

    @MockitoBean
    PingTestConnect pingTestConnect;

    @Test
    void contextLoads() {
    }


}
