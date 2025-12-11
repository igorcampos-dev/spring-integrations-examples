package com.io.example.properties;

import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.annotation.EnableKafka;

@Configuration
@EnableKafka
public class KafkaProperties {
    public static final String KAFKA_TOPIC = "spring-kafka-simple-topic";
}