package com.io.example.service;

import com.github.benmanes.caffeine.cache.Cache;
import com.io.example.client.CaffeineVersionClient;
import com.io.example.dto.CaffeineResponseDto;
import com.io.example.repository.CaffeineDescriptionRepository;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class CaffeineServiceImpl implements CaffeineService{

    private final Cache<@NonNull String, String> caffeineCache;
    private final CaffeineVersionClient client;
    private final CaffeineDescriptionRepository repository;

    @Override
    public CaffeineResponseDto getCaffeineInformation() {
        return new CaffeineResponseDto(getVersion(), getDescription());
    }

    //Simulating external request
    private String getVersion(){
        return caffeineCache.get("caffeine-version", key -> {
            log.info("Sending a request to the external service to get the caffeine version.");
            return client.getVersionCaffeine().version();
        });
    }

    //Simulating database search
    private String getDescription(){
        return caffeineCache.get("caffeine-description", key -> {
            log.info("Fetching the caffeine description from the database.");
            return repository.findCaffeineDescription();
        });
    }

}
