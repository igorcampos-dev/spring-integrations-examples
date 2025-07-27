package com.io.example.controller;

import com.io.example.controller.dto.request.MessageRequestDtoRequest;
import com.io.example.controller.dto.response.SimpleTopicDtoResponse;
import com.io.example.producer.KafkaProducerService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1/example")
public class ExampleController {

    private final KafkaProducerService kafkaProducerService;

    @PostMapping("/send/simple-topic")
    public ResponseEntity<SimpleTopicDtoResponse> sendMessageToSimpleTopic(@RequestBody MessageRequestDtoRequest dto){
        this.kafkaProducerService.sendMessage(dto);
        return ResponseEntity.status(HttpStatus.OK).body(new SimpleTopicDtoResponse("Message sent successfully!"));
    }

}
