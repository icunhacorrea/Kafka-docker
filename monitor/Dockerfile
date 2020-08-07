FROM openjdk:11.0.8-jdk-buster

LABEL maintainer "icorrea <icorrea@inf.ufsm.br>"


RUN apt-get update \
	&& apt-get install git -y \
	&& git clone https://github.com/icunhacorrea/Watcher-kafka.git /root/Watcher-kafka

WORKDIR /root/Watcher-kafka/src

RUN ./compile.sh
