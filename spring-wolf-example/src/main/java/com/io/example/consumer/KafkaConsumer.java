package com.io.example.consumer;

import com.io.example.dto.KafkaDto;
import com.io.example.util.ConstantsUtil;
import io.github.springwolf.bindings.kafka.annotations.KafkaAsyncOperationBinding;
import io.github.springwolf.core.asyncapi.annotations.AsyncListener;
import io.github.springwolf.core.asyncapi.annotations.AsyncOperation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import java.util.function.Consumer;

import static org.springframework.kafka.support.mapping.AbstractJavaTypeMapper.DEFAULT_CLASSID_FIELD_NAME;

@Slf4j
@Component
public class KafkaConsumer implements Consumer<KafkaDto> {

    @KafkaAsyncOperationBinding(bindingVersion = "1.0.0")
    @AsyncListener(operation = @AsyncOperation(
            channelName = ConstantsUtil.KAFKA_TOPIC,
            description = "Tópico que recebe dados de exemplo do kafka",
            servers = {"kafka"},
            headers = @AsyncOperation.Headers(
                    schemaName = "SpringKafkaDefaultHeaders-KafkaDto",
                    values = {
                            @AsyncOperation.Headers.Header(
                                    name = DEFAULT_CLASSID_FIELD_NAME,
                                    value = "com.io.example.dto.KafkaDto",
                                    description = "Type ID")
                    })
    ))
    @Override
    public void accept(KafkaDto kafkaDto) {
        log.info("receive: {}", kafkaDto.message());
    }


}