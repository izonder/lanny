FROM izonder/janny:latest

MAINTAINER Dmitry Morgachev <izonder@gmail.com>

ENV LIQUIBASE_VERSION=3.6.3 \
    LIQUIBASE_PREFIX=/usr/local/lib \
    LIQUIBASE_BIN=/usr/local/bin \
    JDBC_POSTGRES_VERSION=42.2.6 \
    JDBC_MYSQL_VERSION=2.4.2

RUN set -x \

##############################################################################
# Install dependencies
##############################################################################

    && apk add --no-cache \
        curl \

##############################################################################
# Install Liquibase
##############################################################################

    && mkdir ${LIQUIBASE_PREFIX}/liquibase \
    && curl -o /tmp/liquibase-${LIQUIBASE_VERSION}.tar.gz -sSL https://github.com/liquibase/liquibase/releases/download/liquibase-parent-${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}-bin.tar.gz \
    && tar -zxf /tmp/liquibase-${LIQUIBASE_VERSION}.tar.gz -C ${LIQUIBASE_PREFIX}/liquibase \
    && sed -i "s|bash$|ash|" ${LIQUIBASE_PREFIX}/liquibase/liquibase \
    && chmod +x ${LIQUIBASE_PREFIX}/liquibase/liquibase \
    && ln -s ${LIQUIBASE_PREFIX}/liquibase/liquibase ${LIQUIBASE_BIN} \

##############################################################################
# Install JDBC drivers
##############################################################################

    && curl -o ${LIQUIBASE_PREFIX}/liquibase/lib/postgresql-${JDBC_POSTGRES_VERSION}.jar -sSL https://jdbc.postgresql.org/download/postgresql-${JDBC_POSTGRES_VERSION}.jar \
    && curl -o ${LIQUIBASE_PREFIX}/liquibase/lib/mariadb-${JDBC_MYSQL_VERSION}.jar -sSL https://downloads.mariadb.com/Connectors/java/connector-java-${JDBC_MYSQL_VERSION}/mariadb-java-client-${JDBC_MYSQL_VERSION}.jar \

##############################################################################
# Clean up
##############################################################################

    && apk del \
        curl \

    && rm -rf \
        /tmp/* \
        /var/cache/apk/*

VOLUME ["/changelogs"]

ENTRYPOINT ["/init"]
