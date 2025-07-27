package com.io.example.consumer;

import com.io.example.controller.dto.request.MessageRequestDtoRequest;
import com.io.example.mapper.JsonMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
@SuppressWarnings("unused")
public class KafkaConsumerServiceImpl implements KafkaConsumerService {

    private final JsonMapper mapper;

    @KafkaListener(topics = "${spring.kafka.topics.topic-1}" , groupId = "${spring.kafka.consumer.group-id}")
    public void consume(String message) {
        MessageRequestDtoRequest messageRequestDtoRequest = mapper.toObject(message, MessageRequestDtoRequest.class);
        log.info("Message receive: {} ", messageRequestDtoRequest.toString());
    }

}
