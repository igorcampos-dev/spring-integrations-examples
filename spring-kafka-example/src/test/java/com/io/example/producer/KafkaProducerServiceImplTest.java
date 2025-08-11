package com.io.example.producer;

import com.io.example.controller.dto.request.MessageRequestDtoRequest;
import com.io.example.mapper.JsonMapper;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.kafka.test.EmbeddedKafkaBroker;
import org.springframework.kafka.test.context.EmbeddedKafka;
import org.springframework.kafka.test.utils.KafkaTestUtils;
import org.springframework.test.context.ActiveProfiles;

import java.time.Duration;
import java.util.Collections;
import java.util.Map;
import java.util.Properties;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@ActiveProfiles("test")
@EmbeddedKafka(partitions = 1, topics = {"spring-kafka-example-simple-topic-test"})
public class KafkaProducerServiceImplTest {

    @SuppressWarnings("unused")
    @Value("${spring.kafka.topics.topic-1}")
    private String topic_1;

    @SuppressWarnings("unused")
    @Value("${kafka.group-id}")
    private String group_id;

    @Autowired
    @SuppressWarnings("unused")
    private KafkaProducerServiceImpl producer;

    @Autowired
    @SuppressWarnings("unused")
    private JsonMapper mapper;

    @Autowired
    @SuppressWarnings("unused")
    private EmbeddedKafkaBroker embeddedKafkaBroker;

    private MessageRequestDtoRequest message;

    @BeforeEach
    void init(){
        message = new MessageRequestDtoRequest("Teste Kafka");
    }

    @Test
    void testSendMessage() {

        producer.sendMessage(message);

        try (KafkaConsumer<String, String> consumer = new KafkaConsumer<>(this.getProps())) {
            consumer.subscribe(Collections.singleton(topic_1));
            ConsumerRecords<String, String> records = consumer.poll(Duration.ofSeconds(10));

            assertThat(records.count()).isGreaterThan(0);

            ConsumerRecord<String, String> record = records.iterator().next();
            MessageRequestDtoRequest receivedMessage = mapper.toObject(record.value(), MessageRequestDtoRequest.class);
            assertThat(receivedMessage.message()).isEqualTo("Teste Kafka");

        }
    }

    private Properties getProps(){
        Map<String, Object> consumerProps = KafkaTestUtils.consumerProps(group_id, "true", embeddedKafkaBroker);
        Properties props = new Properties();
        props.putAll(consumerProps);
        return props;
    }


}
