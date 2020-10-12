#!/bin/bash

docker-compose down
docker-compose up -d
sleep 3
docker container exec kafka-docker_kafka1_1 bash create-topic.sh 3 3 test-topic
docker container logs kafka-docker_monitor1_1 -f

