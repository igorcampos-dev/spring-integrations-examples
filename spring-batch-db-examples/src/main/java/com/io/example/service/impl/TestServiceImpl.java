package com.io.example.service.impl;

import com.io.example.model.dto.TestDto;
import com.io.example.service.TestService;
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
