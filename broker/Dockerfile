FROM openjdk:11.0.8-jre-buster

LABEL maintainer "icorrea <icorrea@inf.ufsm.br>"


ENV KAFKA_HOME=/opt/kafka

COPY ../files/kafka_2.12-2.3.1.tgz /opt/
COPY ../files/start-kafka.sh /root/

RUN tar -C /opt/ -zxvf /opt/kafka_2.12-2.3.1.tgz \
	&& mv /opt/kafka_2.12-2.3.1 /opt/kafka \
	&& sed -i -e '/^listeners=/d' "$KAFKA_HOME/config/server.properties" \
	&& chmod +x /root/start-kafka.sh \
	&& apt-get update \
	&& apt-get install kafkacat -y

CMD ["/root/start-kafka.sh"]
