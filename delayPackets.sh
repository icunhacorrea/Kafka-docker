#!/bin/bash

docker-compose down -v
docker system prune -f

for delay in 100 200 300; do
	for ack in -2 -1 0 1; do
		for i in {0..19}; do
			echo $i $ack $percent

			docker-compose up -d
			sleep 5
			docker container exec kafkadocker_kafka3_1 bash create-topic.sh 3 3 test-topic
			# Inserção da falha
			./insertDelay.sh $delay &
			# Execução
			docker container exec kafkadocker_producer_1 bash execute.sh test-topic $ack 500000 500 > ./logs/log-$percent-$ack-$i.out

			sleep 900

			count=$( docker container exec kafkadocker_kafka1_1 bash countMessages.sh )
			echo "Quantidade de mensagens: $count" >> ./logs/log-$percent-$ack-$i.out
			# Remoção da falha.
			kill -9 $( pgrep pumba )
			docker-compose down -v
			docker system prune -f

		done
	done
done
