package com.io.example.consumer;

import com.io.example.dto.KafkaDto;
import com.io.example.util.ConstantsUtil;
import io.github.springwolf.bindings.kafka.annotations.KafkaAsyncOperationBinding;
import io.github.springwolf.core.asyncapi.annotations.AsyncListener;
import io.github.springwolf.core.asyncapi.annotations.AsyncOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.Message;
import org.springframework.stereotype.Component;
import java.util.function.Consumer;

import static org.springframework.kafka.support.mapping.AbstractJavaTypeMapper.DEFAULT_CLASSID_FIELD_NAME;

@Slf4j
@Component("kafkaConsumer")
public class KafkaConsumer implements Consumer<Message<KafkaDto>> {

    @KafkaAsyncOperationBinding(bindingVersion = "1.0.0")
    @AsyncListener(operation = @AsyncOperation(
            channelName = ConstantsUtil.KAFKA_TOPIC,
            description = " Topic that receives sample data from Kafka",
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
    public void accept(Message<KafkaDto> message) {
        var kafkaDto = message.getPayload();
        log.info("receive: {}", kafkaDto.message());
    }


}