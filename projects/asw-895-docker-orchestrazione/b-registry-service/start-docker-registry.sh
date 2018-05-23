#!/bin/bash

# IL SERVIZIO DI REGISTRY VIENE AVVIATO NELLO SWARM DALLO SCRIPT START-SWARM-REGISTRY.SH 
# dunque qui non serve, e' solo per documentazione 

# https://docs.docker.com/registry/deploying/

echo 'Starting private registry as a service' 

# nell'ambiente docker-swarm, il registry puo' essere acceduto su my-registry:5000 
# my-registry e' un alias per swarm-1
# inoltre, anche my-swarm e' un alias per swarm-1 

# my-registry:5000 deve essere abilitato come registry insicuro 
# si veda il file di configurazione ${ASW_RESOURCES}/docker.service.d/override.conf 
# anche la cartella /home/asw/data/my-registry deve essere stata creata 

export DOCKER_HOST=tcp://my-swarm:2375

docker service create --name my-registry \
                      --publish 5000:5000 \
					  --restart-condition on-failure \
					  --mount type=bind,src=/home/asw/data/my-registry,dst=/var/lib/registry \
					  registry:2 
