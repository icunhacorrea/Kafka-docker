FROM openjdk:11.0.8-jdk-buster

LABEL maintainer "icorrea <icorrea@inf.ufsm.br>"


RUN apt-get update \
	&& apt-get install git -y \
	&& git clone https://github.com/icunhacorrea/PerformanceKafka.git /root/PerformanceKafka

WORKDIR /root/PerformanceKafka/src

RUN ./compile.sh

CMD ["sh", "-c", "tail -f /dev/null"]