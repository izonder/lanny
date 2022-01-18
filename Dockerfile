FROM izonder/janny:latest

MAINTAINER Dmitry Morgachev <izonder@gmail.com>

ENV LIQUIBASE_VERSION=4.7.0 \
    LIQUIBASE_PREFIX=/usr/local/lib \
    LIQUIBASE_BIN=/usr/local/bin

RUN set -x \

##############################################################################
# Install dependencies
##############################################################################

    && apk add --no-cache \
        curl \

##############################################################################
# Install Liquibase \
# NOTE: it includes all needed JDBC drivers
##############################################################################

    && mkdir ${LIQUIBASE_PREFIX}/liquibase \
    && curl -o /tmp/liquibase-${LIQUIBASE_VERSION}.tar.gz -sSL https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz \
    && tar -zxf /tmp/liquibase-${LIQUIBASE_VERSION}.tar.gz -C ${LIQUIBASE_PREFIX}/liquibase \
    && sed -i "s|bash$|ash|" ${LIQUIBASE_PREFIX}/liquibase/liquibase \
    && chmod +x ${LIQUIBASE_PREFIX}/liquibase/liquibase \
    && ln -s ${LIQUIBASE_PREFIX}/liquibase/liquibase ${LIQUIBASE_BIN} \

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
