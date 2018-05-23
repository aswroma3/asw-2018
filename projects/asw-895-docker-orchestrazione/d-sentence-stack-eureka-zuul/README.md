# Sentence

Questo sottoprogetto mostra come eseguire l'applicazione **sentence** 
come **stack** utilizzando l'**orchestrazione** di contenitori Docker in uno **Swarm Docker**.  

### Build ed esecuzione (Docker Swarm)  

E' possibile costruire e mandare in esecuzione l'applicazione 
utilizzando il nodo **dev** 
dell'ambiente [docker-swarm](../../../environments/docker-swarm/): 

* eseguire lo script `build-all-projects.sh` nella cartella del sottoprogetto 
  per effettuare la build (Java) dei diversi servizi che compongono l'applicazione

* eseguire lo script `build-all-images.sh` per effettuare la build delle immagini dei contenitori Docker 
  e farne il push nel registry privato locale 
 
* eseguire lo script `start-sentence-stack.sh` per mandare in esecuzione l'applicazione come **stack Docker**

* eseguire lo script `stop-sentence-stack.sh` per terminare l'esecuzione dell'applicazione 

**Attenzione**: l'applicazione ci mette qualche minuto a partire. 
  
L'applicazione viene esposta sulla porta `8080` 
di ogni nodo dello swarm, sul path `/sentence`. 
Dal nodo **dev**, il servizio sarà visibile 
all'indirizzo `my-swarm:8080/sentence` 
(si veda lo script `run-curl-client.sh`). 

Sull'host, potrebbe essere accessibile tramite porte diverse, 
in genere sulle porte `8081`, `8082` e `8083` 
(vedere il port forwarding di vagrant dei nodi **swarm-1**, **swarm-2** e **swarm-3**). 

