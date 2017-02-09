# LANNY - a slim docker container image with Liquibase

**LANNY** = **L**iquibase + **A**lpine + **N**ginx + **N**ode.js + **Y**arn

[![](https://images.microbadger.com/badges/version/izonder/lanny.svg)](https://microbadger.com/images/izonder/lanny "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/izonder/lanny.svg)](https://microbadger.com/images/izonder/lanny "Get your own image badge on microbadger.com")
[![Build Status](https://travis-ci.org/izonder/lanny.svg?branch=master)](https://travis-ci.org/izonder/lanny)

## Features

- Alpine linux as base-image
- S6-overlay to run multiple processes in container
- Nginx with basic configuration
- Node.js (fully-static without NPM)
- Yarn package manager
- Java OpenJDK 8
- Liquibase

Liquibase features and limitations:
- YAML/JSON changelogs formats support
- Supported databases out of box according the list: http://www.liquibase.org/databases.html
- To include JAR into classpath just add it to `/usr/local/lib/liquibase/lib` directory

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
