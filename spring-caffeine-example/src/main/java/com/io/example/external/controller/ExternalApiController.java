package com.io.example.external.controller;

import com.github.benmanes.caffeine.cache.Caffeine;
import com.io.example.external.dto.ExternalApiResponseDto;
import lombok.NonNull;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/external")
public class ExternalApiController {

    @GetMapping("/v1/caffeine-version")
    public ResponseEntity<@NonNull ExternalApiResponseDto> getVersionCaffeine(){
        Package caffeinePackage = Caffeine.class.getPackage();
        String version = caffeinePackage.getImplementationVersion();
        return ResponseEntity.ok(new ExternalApiResponseDto(version));
    }

}
