# asw-895-docker-orchestrazione 

Questo progetto contiene alcune applicazioni che esemplificano 
il rilascio di applicazioni composte da uno o più servizi,  
da eseguire su un singolo nodo [docker](../../environments/docker/) 
oppure in un cluster [docker-swarm](../../environments/docker-swarm/). 

In particolare, le applicazioni sono in genere delle varianti di quelle mostrate 
nel progetto [asw-875-spring-cloud/](../asw-875-spring-cloud/). 
Gli esempi sono relativi a due applicazioni principali: 

* l'applicazione **sentence**, mostrata in più versioni   

* una semplice applicazione web **hello**  

Inoltre, a titolo di esempio, il sottoprogetto **b-registry-service** 
mostra gli script per avviare un *registry privato* in uno swarm. 
(Non necessario, perché nell'ambiente [docker-swarm](../../environments/docker-swarm/) 
viene creato un registry privato al momento della preparazione dell'ambiente.)


### Applicazione **sentence**

L'applicazione **sentence** è formata da più servizi, e realizzata in più versioni: 
  
* **a-sentence-compose** va eseguita in un nodo Docker ([docker](../../environments/docker/)), con *Docker* oppure con *Docker Compose* 

* **d-sentence-swarm-eureka-zuul** va eseguita in un cluster Docker ([docker-swarm](../../environments/docker-swarm/)), come *stack Docker* 

* anche **e-sentence-swarm-zuul** va eseguita in un cluster Docker ([docker-swarm](../../environments/docker-swarm/)), come *stack Docker* 


### Servizio **hello-service**

L'applicazione **c-hello-service**, è invece formata da un singolo servizio. 
Si tratta di una semplice applicazione REST, che restituisce un saluto  
che include il nome del nodo in cui viene eseguito il servizio. 
Dopo essere stata compilata, va eseguita come *servizio Docker*, con più repliche, 
in un cluster Docker ([docker-swarm](../../environments/docker-swarm/)). 


### Ambiente di esecuzione 

Queste applicazioni vanno eseguite negli ambienti 
[docker](../../environments/docker/) 
oppure [docker-swarm](../../environments/docker-swarm/). 

