#!/bin/bash

# per arrestare l'esecuzione come servizio in uno swarm  

# DOCKER_REGISTRY=localhost:5000
# my-registry e my-swarm sono degli alias per swarm-1
DOCKER_REGISTRY=my-registry:5000
DOCKER_SWARM=tcp://my-swarm:2375

docker -H ${DOCKER_SWARM} service rm hello 
