package com.io.example.service;

import com.io.example.model.dto.TestDto;
import com.io.example.service.impl.TestServiceImpl;
import org.instancio.Instancio;
import org.junit.jupiter.api.Test;

class TestServiceImplTest {

    private final TestServiceImpl service = new TestServiceImpl();

    @Test
    void print_shouldLogStudent() {
        TestDto testDto = Instancio.create(TestDto.class);
        service.print(testDto);
    }

}
