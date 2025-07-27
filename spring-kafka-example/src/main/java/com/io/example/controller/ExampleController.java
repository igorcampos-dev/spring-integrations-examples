package com.io.example.controller;

import com.io.example.controller.dto.request.MessageRequestDtoRequest;
import com.io.example.controller.dto.response.GetDtoResponse;
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

    @PostMapping("/send")
    public ResponseEntity<GetDtoResponse> sendMessage(@RequestBody MessageRequestDtoRequest dto){
        this.kafkaProducerService.sendMessage(dto.message());
        return ResponseEntity.status(HttpStatus.OK).body(new GetDtoResponse("Message sent successfully!"));
    }

}
