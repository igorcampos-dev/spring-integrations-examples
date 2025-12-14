package com.io.example.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Data
@Component
@ConfigurationProperties(prefix = "caffeine")
public class CaffeineProperties {
    private long expireAfterWrite;
    private int initialCapacity;
    private long maximumSize;
}
