package com.io.example.fileReader.async.service.impl;

import com.io.example.fileReader.async.dto.StudentDto;
import com.io.example.fileReader.async.service.TestService;
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