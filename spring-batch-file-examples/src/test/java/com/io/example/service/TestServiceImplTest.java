package com.io.example.service;

import com.io.example.dto.StudentDto;
import com.io.example.service.impl.TestServiceImpl;
import org.instancio.Instancio;
import org.junit.jupiter.api.Test;

class TestServiceImplTest {

    private final TestServiceImpl service = new TestServiceImpl();

    @Test
    void print_shouldLogStudent() {
        StudentDto student = Instancio.create(StudentDto.class);
        service.print(student);
    }

}
