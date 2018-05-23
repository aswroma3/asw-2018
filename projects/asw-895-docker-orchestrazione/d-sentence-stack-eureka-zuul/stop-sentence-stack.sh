#!/bin/bash

echo 'Halting sentence application as a stack' 

# DOCKER_REGISTRY=localhost:5000
# my-registry e my-swarm sono degli alias per swarm-1
DOCKER_REGISTRY=my-registry:5000
DOCKER_SWARM=tcp://my-swarm:2375

docker -H ${DOCKER_SWARM} stack rm sentence
