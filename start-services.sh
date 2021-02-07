#!/bin/bash

docker-compose down -v
docker system prune -f
docker-compose up -d
sleep 5
docker container exec kafkadocker_kafka3_1 bash create-topic.sh 3 3 test-topic
docker container logs kafkadocker_monitor1_1 -f

