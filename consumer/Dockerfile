FROM python:3.9.0-slim-buster

LABEL maintainer "icorrea <icorrea@inf.ufsm.br>"

COPY ./files/consumer.py /root/

WORKDIR /root

RUN apt-get update \
	&& apt-get install git gcc g++ make vim -y \
	&& git clone https://github.com/edenhill/librdkafka.git /root/librdkafka \
	&& cd /root/librdkafka && ./configure && make && make install && ldconfig && cd \
	&& pip install confluent_kafka \
	&& chmod +x consumer.py

CMD ["sh", "-c", "tail -f /dev/null"]