package com.io.example.producer;

@FunctionalInterface
public interface KafkaProducerService {
    void sendMessage(String mensagem);
}
