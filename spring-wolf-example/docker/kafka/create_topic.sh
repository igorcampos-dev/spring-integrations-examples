#!/bin/bash

echo "Waiting for Kafka on port $KAFKA_PORT..."
while ! nc -z $KAFKA_HOST $KAFKA_PORT; do
  sleep 2
done

/opt/kafka/bin/kafka-topics.sh \
  --create \
  --topic "$KAFKA_TOPIC_CREATE" \
  --bootstrap-server $KAFKA_HOST:$KAFKA_PORT \
  --partitions 1 \
  --replication-factor 1

echo "Topic $KAFKA_TOPIC_CREATE created successfully!"