#!/bin/bash

# per scalare un servizio in esecuzione in uno swarm

# DOCKER_REGISTRY=localhost:5000
# my-registry e my-swarm sono degli alias per swarm-1
DOCKER_REGISTRY=my-registry:5000
DOCKER_SWARM=tcp://my-swarm:2375

docker -H ${DOCKER_SWARM} service scale hello=5
