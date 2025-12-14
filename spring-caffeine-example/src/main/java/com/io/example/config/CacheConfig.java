package com.io.example.config;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import com.io.example.properties.CaffeineProperties;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import java.time.Duration;

@Configuration
@RequiredArgsConstructor
public class CacheConfig {

    private final CaffeineProperties properties;

    @Bean
    public Cache<@NonNull String, String> caffeineCache() {
        return Caffeine.newBuilder()
                .expireAfterWrite(Duration.ofSeconds(properties.getExpireAfterWrite()))
                .initialCapacity(properties.getInitialCapacity())
                .maximumSize(properties.getMaximumSize())
                .build();
    }

}