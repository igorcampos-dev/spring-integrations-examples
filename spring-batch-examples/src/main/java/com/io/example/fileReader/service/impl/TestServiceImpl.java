package com.io.example.fileReader.service.impl;

import com.io.example.fileReader.dto.StudentDto;
import com.io.example.fileReader.service.TestService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class TestServiceImpl implements TestService {

    @Override
    public void print(StudentDto studentDto) {
        log.info("Processed: {}", studentDto);
    }

}