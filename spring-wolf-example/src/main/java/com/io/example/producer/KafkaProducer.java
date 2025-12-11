package com.io.example.producer;

import com.io.example.properties.KafkaProperties;
import com.io.example.dto.KafkaDto;
import io.github.springwolf.bindings.kafka.annotations.KafkaAsyncOperationBinding;
import io.github.springwolf.core.asyncapi.annotations.AsyncOperation;
import io.github.springwolf.core.asyncapi.annotations.AsyncPublisher;
import lombok.RequiredArgsConstructor;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.stereotype.Component;

import static org.springframework.kafka.support.mapping.AbstractJavaTypeMapper.DEFAULT_CLASSID_FIELD_NAME;

@Component
@RequiredArgsConstructor
public class KafkaProducer {

    private final StreamBridge bridge;

    @AsyncPublisher(
            operation = @AsyncOperation(
                    servers = {"kafka"},
                    channelName = KafkaProperties.KAFKA_TOPIC,
                    description = "Tópico de exemplo pra envio de mensagens",
                    payloadType = KafkaDto.class,
                    headers = @AsyncOperation.Headers(
                            schemaName = "SpringKafkaDefaultHeaders-KafkaDto",
                            values = {
                                    @AsyncOperation.Headers.Header(
                                            name = DEFAULT_CLASSID_FIELD_NAME,
                                            value = "com.example.dto.KafkaDto",
                                            description = "Type ID")
                            })
            )
    )
    @KafkaAsyncOperationBinding(bindingVersion = "1.0.0")
    public void send(String text) {
        KafkaDto message = new KafkaDto(text);
        bridge.send("sendMessage-out-0", message);
    }

}