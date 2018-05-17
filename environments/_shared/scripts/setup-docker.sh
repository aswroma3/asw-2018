#!/bin/bash

source "/home/asw/_shared/scripts/common.sh"

# see https://docs.docker.com/install/linux/docker-ce/ubuntu/

# set up Docker constants 
DOCKER_VERSION=18.03.0~ce-0~ubuntu

# Per vedere le versioni disponibili 
# apt-cache madison docker-ce

echo "================="
echo "installing docker"
echo "================="

# per Ubuntu 16.04 LTS 
# per Ubuntu 14.04 LTS ci sarebbero delle differenze (vedi 2017) 
VAGRANT_USER=vagrant 

#
# copia il file OVERRIDE.CONF per sovrascrivere la configurazione di docker 
# - abilita la comunicazione remota del nodo 
# - abilita my-registry:5000 come registry insicuro 
# 
mkdir -p /etc/systemd/system/docker.service.d
cp ${ASW_RESOURCES}/docker.service.d/override.conf /etc/systemd/system/docker.service.d/override.conf
chmod a-x /etc/systemd/system/docker.service.d/override.conf

# Update the apt package index 
apt-get update 

# Install packages to allow apt to use a repository over HTTPS:
apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add Docker’s official GPG key: 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Set up the stable repository
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Update (again) the apt package index 
apt-get update 

# Per vedere le versioni disponibili 
# apt-cache madison docker-ce

# Per installare una versione specifica (raccomandato in produzione) 
apt-get -y install docker-ce=${DOCKER_VERSION}

# Install the latest version of Docker CE 
# apt-get -y install docker-ce

# Alcuni esempi per verificare l'installazione 
# docker run hello-world
# docker run docker/whalesay cowsay Hello, world! 
# docker run -it ubuntu bash

##### post-installation 

groupadd docker

# abilita l'utente vagrant 
usermod -aG docker ${VAGRANT_USER}
# Remember to log out and back in for this to take effect! 

##### configure docker to start on boot 

### Su Ubuntu 16.04: (la documentazione indica solo il secondo)
systemctl daemon-reload
systemctl enable docker 
systemctl restart docker

### Su Ubuntu 14.04 viene avviato di default 

##### ABILITA l'ACCESSO REMOTO 
# non serve: vedi il file OVERRIDE.CONF  
