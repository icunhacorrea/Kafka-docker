#!/bin/bash

docker-compose down -v
docker system prune -f

for percent in 2 4 6 8 10; do
	for ack in -2 -1 0 1; do
		for i in {0..19}; do
			echo $i $ack $percent

			docker-compose up -d
			sleep 5
			docker container exec kafka-docker_kafka3_1 bash create-topic.sh 3 3 test-topic
			# Inserção da falha
			pumba netem -d 3600h loss-state --p13 0 --p14 $percent  $( dock ps | grep -e kafka\[0-9] -e kafka-producer | awk '{ print $NF }' ) &
			docker container exec kafka-docker_producer_1 bash execute.sh test-topic $ack 500000 500 > ./logs/log-$percent-$ack-$i.out
			sleep 180
			docker container exec kafka-docker_kafka1_1 bash countMessages.sh >> ./logs/log-$percent-$ack-$i.out
			# Remoção da falha.
			kill -9 $( pgrep pumba )
			docker-compose down -v
			docker system prune -f

		done
	done
done