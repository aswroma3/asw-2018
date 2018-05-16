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

# copia il file per sovrascrivere la configurazione di docker 
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

##### abilita l'accesso remoto 
# va usata la porta 2375 per l'accesso insicuro e la 2376 per quello sicuro con TLS 

# calcola il mio indirizzo IP (sulla rete 10.11.1.xx)
### MY_IP_ADDR=$(ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}' | grep '10.11.1.')

### da rimettere dentro 

### Per Ubuntu 16.04: https://docs.docker.com/engine/admin/systemd/
## da eseguire dopo systemctl enable docker (che crea il file docker.service) 
### sed '\_ExecStart_s_$_ -H tcp://'${MY_IP_ADDR}':2375 -H unix:///var/run/docker.sock_' /lib/systemd/system/docker.service > /tmp/docker.service.new
### mv /tmp/docker.service.new /lib/systemd/system/docker.service

### Istruzioni per Ubuntu 14.04: https://docs.docker.com/engine/admin/
# appende DOCKER_OPTS='-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock' alla fine di /etc/default/docker
# sudo echo "DOCKER_OPTS='-H tcp://${MY_IP_ADDR}:2375 -H unix:///var/run/docker.sock'" >> /etc/default/docker
