#!/bin/bash

docker save siddontang/mariadb | docker-squash -verbose -from root -t siddontang/mariadb | docker load
docker images --no-trunc | grep none | awk '{print $3}' | xargs docker rmi
