#!/bin/bash

echo 'Halting private registry' 

# nell'ambiente docker-swarm, il registry puo' essere acceduto su docker-registry:5000 
# docker-registry e' un alias per swarm-1
# inoltre, swarm e' un altro alias per swarm-1 

export DOCKER_HOST=tcp://my-swarm:2375

docker service rm my-registry 
