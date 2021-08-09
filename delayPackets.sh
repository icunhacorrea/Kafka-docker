#!/bin/bash

docker-compose down -v
docker system prune -f

for delay in 100 200 300; do
	for ack in 0; do
		for i in {20..39}; do
			echo $i $ack $delay

			docker-compose up -d
			sleep 5
			docker container exec kafkadocker_kafka3_1 bash create-topic.sh 3 3 test-topic
			# Inserção da falha
			./insertDelay.sh $delay $ack $i &
			# Execução
			docker container exec kafkadocker_producer_1 bash execute.sh test-topic $ack 500000 500 > ./logs/log-$delay-$ack-$i.out

			sleep 600

			count=$( docker container exec kafkadocker_kafka1_1 bash countMessages.sh )
			echo "Quantidade de mensagens: $count" >> ./logs/log-$delay-$ack-$i.out
				docker container logs kafkadocker_monitor1_1 >> ./logs/log-monitor-$delay-$ack-$i.out
			# Remoção da falha.
			kill -9 $( pgrep pumba )
			docker-compose down -v
			docker system prune -f

		done
	done
done
