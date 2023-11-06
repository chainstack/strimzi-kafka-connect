FROM quay.io/strimzi/kafka:0.38.0-kafka-3.6.0
USER root:root
ENV KAFKA_CONNECT_JDBC_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-jdbc

ARG POSTGRES_VERSION=42.6.0
ARG KAFKA_JDBC_VERSION=5.5.9

# Deploy PostgreSQL JDBC Driver
RUN mkdir -p /opt/kafka/plugins/mysql && cd /opt/kafka/plugins/mysql && \
    curl -sO https://repo1.maven.org/maven2/io/debezium/debezium-connector-mysql/2.4.0.Final/debezium-connector-mysql-2.4.0.Final-plugin.tar.gz && \
    tar -xvzf /opt/kafka/plugins/mysql/debezium-connector-mysql-2.4.0.Final-plugin.tar.gz --directory /opt/kafka/plugins/mysql/ && \
    rm /opt/kafka/plugins/mysql/debezium-connector-mysql-2.4.0.Final-plugin.tar.gz
RUN mkdir -p /opt/kafka/plugins/jdbc && cd /opt/kafka/plugins/jdbc && \
    curl -sO https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/$KAFKA_JDBC_VERSION/kafka-connect-jdbc-$KAFKA_JDBC_VERSION.jar &&  \
    curl -sO https://jdbc.postgresql.org/download/postgresql-$POSTGRES_VERSION.jar
RUN mkdir -p /opt/kafka/plugins/mongo && \
    cd /opt/kafka/plugins/mongo && \
    curl -L -sO https://repo1.maven.org/maven2/io/debezium/debezium-connector-mongodb/2.4.0.Final/debezium-connector-mongodb-2.4.0.Final.jar
RUN mkdir -p /opt/kafka/plugins/record2row && \
    cd /opt/kafka/plugins/record2row && \
    curl -L -sO https://github.com/kazanzhy/kafka-connect-transform-record2row/releases/download/v0.2.0/kafka-connect-transform-record2row-assembly.jar

USER 1001
