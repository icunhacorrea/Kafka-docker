#!/bin/bash

docker-compose down -v
docker system prune -f

for percent in 6 9; do
	for ack in -1 1; do
		for i in {0..19}; do
			echo $i $ack $percent

			docker-compose up -d
			sleep 5
			docker container exec kafkadocker_kafka3_1 bash create-topic.sh 3 3 test-topic
			# Inserção da falha
			pumba netem -d 36h loss-state --p13 $percent $( docker ps | grep -e kafka\[0-9] -e kafka-producer | awk '{ print $NF }' ) &
			sleep 5

			# Execução
			docker container exec kafkadocker_producer_1 bash execute.sh test-topic $ack 500000 500 > ./logs/log-$percent-$ack-$i.out

			sleep 600

			count=$( docker container exec kafkadocker_kafka1_1 bash countMessages.sh )
			echo "Quantidade de mensagens: $count" >> ./logs/log-$percent-$ack-$i.out
			docker container logs kafkadocker_monitor1_1 > ./logs/log-monitor-$percent-$ack-$i.out
			# Remoção da falha.
			kill -9 $( pgrep pumba )
			docker-compose down -v
			docker system prune -f

		done
	done
done
