#!/bin/bash

LIMIT_MESAGES=240000

while true; do
	count=$( docker container exec kafkadocker_kafka1_1 bash countMessages.sh )
	echo "Count: $count; Delay: $1"
	if [ $count -gt $LIMIT_MESAGES ]; then
		echo "Introduzindo falha..."
		pumba netem -d 60s delay -t $1 $( docker ps | grep kafka-producer | awk '{ print $NF }' )
		break
	fi
	sleep 2
done

