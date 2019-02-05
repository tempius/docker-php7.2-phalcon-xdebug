#!/bin/bash

docker build -t php7.2-phalcon-xdebug .;
export DOCKER_ID_USER=tempius;
docker tag php7.2-phalcon-xdebug $DOCKER_ID_USER/php7.2-phalcon-xdebug:latest;
docker push $DOCKER_ID_USER/php7.2-phalcon-xdebug;
