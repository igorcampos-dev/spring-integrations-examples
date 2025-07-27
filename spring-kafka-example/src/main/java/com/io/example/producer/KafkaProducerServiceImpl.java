package com.io.example.producer;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
@SuppressWarnings("unused")
public class KafkaProducerServiceImpl implements KafkaProducerService {

    @SuppressWarnings("unused")
    @Value("${spring.kafka.topics.topic-1}")
    private String topic;

    private final KafkaTemplate<String, String> kafkaTemplate;

    @Override
    public void sendMessage(String message) {
        log.info("Preparing to send message to Kafka topic: {}", topic);
        kafkaTemplate.send(topic, message);
        log.info("Message successfully dispatched: {}", message);
    }

}
