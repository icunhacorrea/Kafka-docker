#!/bin/bash

for percent in 0 2 4 6 8 10; do
	for ack in -2 -1 0 1; do
		for i in {0..19}; do
			echo $i $ack $percent

			docker-compose down
			docker-compose up -d
			sleep 5
			docker container exec kafka-docker_kafka3_1 bash create-topic.sh 3 3 test-topic

			pumba netem -d 3600h loss-state --p13 0 --p14 $percent  $( dock ps | grep -e kafka\[0-9] -e kafka-producer | awk '{ print $NF }' ) &

			

		done
	done
done