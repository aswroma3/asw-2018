#!/bin/bash

# DOCKER_REGISTRY=localhost:5000
# my-registry e my-swarm sono degli alias per swarm-1
DOCKER_REGISTRY=my-registry:5000
DOCKER_SWARM=tcp://my-swarm:2375

docker build --rm -t ${DOCKER_REGISTRY}/word-img-alt ./word-service 
docker build --rm -t ${DOCKER_REGISTRY}/sentence-img-alt ./sentence-service
docker build --rm -t ${DOCKER_REGISTRY}/sentence-zuul-img-alt ./zuul

docker push ${DOCKER_REGISTRY}/word-img-alt
docker push ${DOCKER_REGISTRY}/sentence-img-alt
docker push ${DOCKER_REGISTRY}/sentence-zuul-img-alt






