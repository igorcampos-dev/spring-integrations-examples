package com.io.example.service;

import com.io.example.dto.StudentDto;
import com.io.example.service.impl.StudentServiceImpl;
import org.instancio.Instancio;
import org.junit.jupiter.api.Test;

class StudentServiceImplStudent {

    private final StudentServiceImpl service = new StudentServiceImpl();

    @Test
    void print_shouldLogStudent() {
        StudentDto student = Instancio.create(StudentDto.class);
        service.print(student);
    }

}
