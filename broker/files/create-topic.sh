#!/bin/bash

$KAFKA_HOME/bin/kafka-topics.sh --create --bootstrap-server kafka1:9093,kafka2:9094,kafka3:9095 --replication-factor $1 --partitions $2 --topic $3

kafkacat -L -b kafka1:9093,kafka2:9094,kafka3:9095 -t $3
