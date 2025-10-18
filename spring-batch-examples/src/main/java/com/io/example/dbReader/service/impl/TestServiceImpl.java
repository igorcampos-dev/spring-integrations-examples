package com.io.example.dbReader.service.impl;

import com.io.example.dbReader.model.dto.TestDto;
import com.io.example.dbReader.service.TestService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class TestServiceImpl implements TestService {

    @Override
    public void print(TestDto dto) {
        log.info("Processed: {}", dto);
    }

}
