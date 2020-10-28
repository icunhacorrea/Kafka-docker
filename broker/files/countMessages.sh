#!/bin/bash

$KAFKA_HOME/bin/kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list 172.21.0.5:9092 \
	--topic test-topic --time -1 --offsets 1 | awk -F  ":" '{sum += $3} END {print sum}'