package com.io.example.mapper;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class JsonMapper {

    private final ObjectMapper objectMapper;

    public String toJsonString(Object obj) {
        try {
            return objectMapper.writeValueAsString(obj);
        } catch (JsonProcessingException e) {
            log.error("error converting an object of type {} to json. cause of the error: {}", obj.getClass(), e.getMessage());
            throw new RuntimeException("JSON serialization failed", e);
        }
    }

    public <T> T toObject(String jsonBody, Class<T> typeClass){
        try {
            return objectMapper.readValue(jsonBody, typeClass);
        } catch (JsonProcessingException e) {
            log.error("error converting an String to object. cause of the error: {}", e.getMessage());
            throw new RuntimeException("Object deserialization failed", e);
        }
    }

}
