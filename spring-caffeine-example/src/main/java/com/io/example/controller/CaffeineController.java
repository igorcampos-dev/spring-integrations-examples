package com.io.example.controller;

import com.io.example.dto.CaffeineResponseDto;
import com.io.example.service.CaffeineService;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/caffeine")
public class CaffeineController {

    private final CaffeineService service;

    @GetMapping("/v1/request")
    public ResponseEntity<@NonNull CaffeineResponseDto> test(){
        var response = service.getCaffeineInformation();
        return ResponseEntity.ok(response);
    }

}
