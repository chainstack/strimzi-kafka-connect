FROM quay.io/strimzi/kafka:0.38.0-kafka-3.6.0
USER root:root

ARG POSTGRES_VERSION=42.6.0
ARG KAFKA_JDBC_VERSION=5.5.9
ARG DEBEZIUM_CONNECTOR_VERSION=2.4.0.Final
ENV KAFKA_CONNECT_PLUGIN_PATH=/opt/kafka/plugins

# Deploy PostgreSQL JDBC Driver
RUN mkdir -p $KAFKA_CONNECT_PLUGIN_PATH/mysql && cd $KAFKA_CONNECT_PLUGIN_PATH/mysql && \
    curl -sO https://repo1.maven.org/maven2/io/debezium/debezium-connector-mysql/${DEBEZIUM_CONNECTOR_VERSION}/debezium-connector-mysql-${DEBEZIUM_CONNECTOR_VERSION}-plugin.tar.gz | tar xz

RUN mkdir -p $KAFKA_CONNECT_PLUGIN_PATH/jdbc && cd $KAFKA_CONNECT_PLUGIN_PATH/jdbc && \
    curl -sO https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/$KAFKA_JDBC_VERSION/kafka-connect-jdbc-$KAFKA_JDBC_VERSION.jar &&  \
    curl -sO https://jdbc.postgresql.org/download/postgresql-$POSTGRES_VERSION.jar

RUN mkdir -p $KAFKA_CONNECT_PLUGIN_PATH/mongo && \
    cd $KAFKA_CONNECT_PLUGIN_PATH/mongo && \
    curl -sfSL https://repo1.maven.org/maven2/io/debezium/debezium-connector-mongodb/${DEBEZIUM_CONNECTOR_VERSION}/debezium-connector-mongodb-${DEBEZIUM_CONNECTOR_VERSION}-plugin.tar.gz | tar xz

RUN mkdir -p $KAFKA_CONNECT_PLUGIN_PATH/record2row && \
    cd $KAFKA_CONNECT_PLUGIN_PATH/record2row && \
    curl -L -sO https://github.com/kazanzhy/kafka-connect-transform-record2row/releases/download/v0.2.0/kafka-connect-transform-record2row-assembly.jar

USER 1001
