#!/bin/bash

# per l'esecuzione come servizio in uno swarm  

# DOCKER_REGISTRY=localhost:5000
# my-registry e my-swarm sono degli alias per swarm-1
DOCKER_REGISTRY=my-registry:5000
DOCKER_SWARM=tcp://my-swarm:2375

docker build --rm -t ${DOCKER_REGISTRY}/hello-img . 

docker push ${DOCKER_REGISTRY}/hello-img

docker -H ${DOCKER_SWARM} service create --name hello --publish 8080:8080 --mode replicated --replicas 2 ${DOCKER_REGISTRY}/hello-img 

