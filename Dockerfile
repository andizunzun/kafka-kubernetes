FROM openjdk:8u212-jdk-alpine3.9
ENV KAFKA_ZOOKEEPER_CONNECT_HOST=localhost
ENV KAFKA_ZOOKEEPER_CONNECT_PORT=2181
RUN apk update && apk add bash \
	&& apk --no-cache add curl
WORKDIR /opt/kafka
RUN curl https://www-us.apache.org/dist/kafka/2.3.0/kafka_2.12-2.3.0.tgz --output kafka.tgz \
	&& tar -xvf kafka.tgz
WORKDIR kafka_2.12-2.3.0
COPY ./start_kafka.sh start_kafka.sh
RUN cd config && sed -i "s/localhost/$KAFKA_ZOOKEEPER_CONNECT_HOST/g" server.properties \
	&& sed -i "s/2181/$KAFKA_ZOOKEEPER_CONNECT_PORT/g" server.properties
CMD []
