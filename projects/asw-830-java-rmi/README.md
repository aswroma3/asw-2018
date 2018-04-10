# asw-830-java-rmi

Questo progetto contiene alcune applicazioni distribuite 
di tipo **client-server** a **oggetti distribuiti** 
basate sull'**invocazione remota** e **Java RMI**: 

* **a-hello-rmi** 
  una semplice applicazione client-server completamente stateless basata su Java RMI

* **b-counter-rmi** 
  un'applicazione client-server basata su Java RMI, 
  in cui il servizio mantiene uno stato globale, 
  che � il contatore di quante volte il servizio � stato chiamato 
  (il servizio per� � *stateless*) 

* **c-session-counter-rmi** 
  un'applicazione client-server basata su Java RMI, 
  in cui il servizio � *stateful*, 
  che conta quante il servizio � stato chiamato da un client 
  (nell'ambito della sessione con quel client) 

Le diverse applicazioni hanno una struttura simile, 
e la loro costruzione ed esecuzione � descritta qui di seguito. 

## Build  

Per la costruzione di ciascuna di queste applicazioni, 
vedere le istruzioni descritte nella sezione [projects/](../). 

## Componenti eseguibili 

Ciascuna applicazione � composta da due componenti eseguibili (**server** e **client**) 
che dopo la costruzione sono presenti 
nelle cartelle **dist/server** e **dist/client** dell'applicazione. 

## Ambiente di esecuzione 

Ciascuna applicazione va eseguita nell'ambiente 
[client-server](../../environments/client-server/): 
il componente **server** sul nodo **server** e
il componente **client** sul nodo **client**.


## Esecuzione 

Per eseguire un'applicazione si proceda in questo modo: 

1. sul nodo **server** 

   a. posizionarsi nella cartella principale dell'applicazione 

   b. eseguire lo script `dist/server/start-rmiregistry.sh` (che avvia il registry RMI)

   c. eseguire lo script `dist/server/run-server.sh` (che avvia il servizio) 
   
   d. il server pu� essere arrestato con CTRL-C 
   
   e. alla fine, il registry RMI pu� essere arrestato eseguendo lo script `dist/server/stop-rmiregistry.sh` 

2. sul nodo **client** 

   a. posizionarsi nella cartella principale dell'applicazione 

   b. eseguire lo script `dist/client/run-client.sh` 

