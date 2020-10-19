#!/bin/bash

$KAFKA_HOME/bin/kafka-topics.sh --create --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
								--replication-factor $1 --partitions $2 --topic $3 \
								--config min.insync.replicas=$1

kafkacat -L -b 172.21.0.5:9092,172.21.0.6:9092,172.21.0.7:9092 -t $3
