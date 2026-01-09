package com.io.example.service.impl;

import com.io.example.dto.StudentDto;
import com.io.example.service.StudentService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class StudentServiceImpl implements StudentService {

    @Override
    public void print(StudentDto studentDto) {
        log.info("Processed: {}", studentDto);
    }

}