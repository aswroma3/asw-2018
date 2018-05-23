# Hello

Questo sottoprogetto esemplifica come eseguire un'applicazione web Spring Boot 
come **servizio Docker** in uno **Swarm Docker**. 

### Build ed esecuzione (Docker Swarm)  

E' possibile costruire e mandare in esecuzione l'applicazione 
utilizzando il nodo **dev** 
dell'ambiente [docker-swarm](../../../environments/docker-swarm/): 

* eseguire `gradle build` per effettuare la build (Java) dell'applicazione  

* eseguire lo script `run-hello-service.sh` per costruire e mandare in esecuzione 
  nello swarm l'applicazione come **servizio Docker** 
 
* eseguire lo script `scale-hello-service.sh` per modificare il numero di repliche 
  del servizio 

* eseguire lo script `stop-hello-service.sh` per arrestare l'esecuzione del servizio 
  
Il servizio viene esposto sulla porta `8080` di ogni nodo dello swarm. 
Dal nodo **dev**, il servizio sarà visibile 
all'indirizzo `my-swarm:8080` 
(si veda lo script `run-curl-client.sh`). 

Sull'host, potrebbe essere accessibile tramite porte diverse, 
in genere sulle porte `8081`, `8082` e `8083` 
(vedere il port forwarding di vagrant dei nodi **swarm-1**, **swarm-2** e **swarm-3**). 

