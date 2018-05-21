#!/bin/bash

HOSTS_FILE=/etc/hosts 

# aggiunge un # all'inizio delle linee che iniziano con 127.0.0.1 e 127.0.1.1 
function createModifiedHostsFile
{
	echo "modifying 127.0.x.x entries in /etc/hosts"
	# Legge il file $INFILE e lo copia in $OUTFILE, ma: 
	# - aggiunge un # all'inizio delle linee che iniziano con 127.0. 
	sed s/^'127.0.'/'# 127.0.'/ ${HOSTS_FILE} > ${HOSTS_FILE}.new
	# aggiunge di nuovo 127.0.0.1 localhost
    echo "127.0.0.1 localhost" >> ${HOSTS_FILE}.new 
	mv ${HOSTS_FILE} ${HOSTS_FILE}.bak
	mv ${HOSTS_FILE}.new ${HOSTS_FILE}
}

# aggiunge a /etc/hosts le seguenti entry 
# - "10.11.1.71 swarm-1 my-swarm my-registry"
# - "10.11.1.72 swarm-2 my-swarm my-registry"
# - "10.11.1.73 swarm-3 my-swarm my-registry"
#
# in teoria, my-swarm e my-registry dovrebbero essere serviti da un DNS, 
# a rotazione su uno qualunque di questi nodi 
# in pratica, facendo così, my-swarm e my-registry coincidono con swarm-1
#
function setupSwarmHostsFile {
	echo "adding entries for swarm nodes to /etc/hosts"
	echo "10.11.1.71 swarm-1 my-swarm my-registry" >> ${HOSTS_FILE}
	echo "10.11.1.72 swarm-2 my-swarm my-registry" >> ${HOSTS_FILE}
	echo "10.11.1.73 swarm-3 my-swarm my-registry" >> ${HOSTS_FILE}
}

echo "setup /etc/hosts on a swarm/dev node"
createModifiedHostsFile
setupSwarmHostsFile