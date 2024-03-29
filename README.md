# LANNY - a slim docker container image with Liquibase

**LANNY** = **L**iquibase + **A**lpine + **N**ginx + **N**ode.js + **Y**arn

[![Build Docker image](https://github.com/izonder/lanny/actions/workflows/docker-image.yml/badge.svg)](https://github.com/izonder/lanny/actions/workflows/docker-image.yml)

## IMPORTANT! Breaking changes announcement

Due to new JDK version we have released a major upgrade, which contains:
- [OpenJDK 17](https://openjdk.org/projects/jdk/17/)
- [Parent package v18](https://hub.docker.com/r/izonder/janny/)

Please be aware of that and make sure these changes won't affect your functionality.

## Features

- Alpine linux as base-image
- S6-overlay to run multiple processes in container
- Nginx v1.24.x with basic configuration
- Node.js v18.x.x
- Yarn package manager
- Java OpenJDK 17 (JRE)
- Liquibase

## Supported tags

- `latest` [(Dockerfile)](https://github.com/izonder/lanny/blob/master/Dockerfile)
- `18` [(Dockerfile)](https://github.com/izonder/lanny/blob/nodejs-18/Dockerfile)
- `16` [(Dockerfile)](https://github.com/izonder/lanny/blob/nodejs-16/Dockerfile)
- `14` [(Dockerfile)](https://github.com/izonder/lanny/blob/nodejs-14/Dockerfile)
- `12` [(Dockerfile)](https://github.com/izonder/lanny/blob/nodejs-12/Dockerfile)
- `10` [(Dockerfile)](https://github.com/izonder/lanny/blob/nodejs-10/Dockerfile)
- `3.5.3` (ad-hoc: the version with Liquibase v3.5.3)

## Liquibase features and limitations

- YAML/JSON changelogs formats support
- Supported databases according the list: http://www.liquibase.org/databases.html
- Pre-installed JDBC drivers for Postgres, MariaDB/MySQL
- To include JAR into classpath just add it to `/usr/local/lib/liquibase/lib` directory

## FAQ

**Q1.** I got an error `Cannot find database driver: com.mysql.jdbc.Driver`

**A1.** To use pre-installed MariaDB/J Connector you should specify `--driver=org.mariadb.jdbc.Driver` or install your own native MySQL/J Connector here: https://dev.mysql.com/downloads/connector/j/

---

**Q2.** Where can I find other JDBC drivers?

**A2.** Use this table:

| DBMS | JDBC driver | URL |
|---|---|---|
| MySQL | com.mysql.jdbc.Driver | http://dev.mysql.com/downloads/connector/j/ |
| MariaDB | org.mariadb.jdbc.Driver | https://downloads.mariadb.org/connector-java/ |
| PostgreSQL | org.postgresql.Driver | https://jdbc.postgresql.org/download.html |
| MSSQL	| com.microsoft.jdbc.sqlserver.SQLServerDriver | http://www.microsoft.com/en-us/download |
| Oracle | oracle.jdbc.OracleDriver | http://www.oracle.com/technetwork/database/jdbc-112010-090769.html |
| SQLite | org.sqlite.JDBC | https://github.com/xerial/sqlite-jdbc/releases |
| FireBird | org.firebirdsql.jdbc | http://www.firebirdsql.org/en/jdbc-driver/ |
| Derby	| org.apache.derby.jdbc.ClientDriver | http://db.apache.org/derby/derby_downloads.html |

---

## How to use?

```
FROM izonder/anny:latest

...

# add new service
COPY ./service/myservice.sh /etc/services.d/myservice/run

...

# add nginx configuration
COPY ./nginx/myapp.conf /etc/nginx/conf.d/myapp.conf

...

# install dependencies
RUN yarn install

...

# apply database migrations
RUN liquibase [options] [command] [command parameters]

...

# entry point
CMD ["node", "myapp.js"]
```
