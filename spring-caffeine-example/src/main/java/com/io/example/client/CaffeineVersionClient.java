package com.io.example.client;

import com.io.example.external.dto.ExternalApiResponseDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

@FeignClient(
    name = "caffeineVersionClient",
    url = "${external.caffeine-version-url}"
)
public interface CaffeineVersionClient {

    @GetMapping("/v1/caffeine-version")
    ExternalApiResponseDto getVersionCaffeine();

}