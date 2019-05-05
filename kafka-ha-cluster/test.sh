#!/bin/bash

# create topic
/opt/kafka/bin/kafka-topics.sh --create --zookeeper 192.168.2.131:2181,192.168.2.132:2181,192.168.2.133:2181 --replication-factor 2 --partitions 1 --topic test

# send messages
echo -e 'aaaa\nbbbb' | /opt/kafka/bin/kafka-console-producer.sh --brokelist 192.168.2.131:9092,192.168.2.132:9092,192.168.2.133:9092 --topic test

# receive messages
/opt/kafka/bin/kafka-console-consumer.sh --timeout-ms 10000 --bootstrap-server 192.168.2.131:9092,192.168.2.132:9092,192.168.2.133:9092 --topic test --from-beginning
