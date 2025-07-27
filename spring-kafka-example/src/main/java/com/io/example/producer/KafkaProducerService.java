package com.io.example.producer;

import com.io.example.controller.dto.request.MessageRequestDtoRequest;

@FunctionalInterface
public interface KafkaProducerService {
    void sendMessage(MessageRequestDtoRequest mensagem);
}
