# GlassFish 

Questo è un ambiente di esecuzione per applicazioni Java EE, 
ed è composto da due macchine virtuali: 
un server **glassfish** e un **client**. 

## Descrizione delle macchine virtuali 

### glassfish

La macchina virtuale **glassfish**  
è per l'esecuzione di applicazioni Java EE *lato server*, 
ed ha il seguente software: 

* Ubuntu 16.04 LTS a 64 bit (by Bento) 

* Oracle Java SDK 

* Oracle Java EE 8 (Payara Server 5.181 full, basato su Glassfish 5.0) 

Configurazione di rete 

* Indirizzo IP: 10.11.1.111 

* Porte pubblicate sull'host: 8080 
 
### client

La macchina virtuale **client**  
è per l'esecuzione di applicazioni Java EE *lato client*, 
ed ha il seguente software: 

* Ubuntu 16.04 LTS a 64 bit (by Bento) 

* Oracle Java SDK 

* appclient per Oracle Java EE 8 (Payara Server 5.181 full) 

* altre librerie client, come *curl* 

Configurazione di rete 

* Indirizzo IP: 10.11.1.211 

