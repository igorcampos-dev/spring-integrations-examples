package com.io.example.consumer;

import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@SuppressWarnings("unused")
public class KafkaConsumerServiceImpl implements KafkaConsumerService {

    @KafkaListener(topics = "${spring.kafka.topics.topic-1}" , groupId = "${spring.kafka.consumer.group-id}")
    public void consume(String message) {
        log.info("Message receive: {} ", message);
    }

}
