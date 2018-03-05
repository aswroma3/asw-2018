# asw-810-introduzione

Questo progetto contiene alcune semplici applicazioni 
per introdurre l'uso dei **connettori**: 

* **a-chiamata-locale**

* **b-factory**

* **c-iniezione-delle-dipendenze** 

* **d-application-context** 

* **e-spring** 

* **f-proxy**

* **g-client-server** 

Solo l'ultima applicazione � un'applicazione distribuita. 
Tutte le altre sono applicazioni non distribuite. 
Ne descriviamo l'uso separatamente 

## Applicazioni non distribuite (tutte tranne **g-client-server**) 

### Build  

Per la costruzione di ciascuna applicazione, vedere le istruzioni 
descritte nella sezione [projects/](../). 

### Componenti eseguibili 

Ciascuna di queste applicazioni � composta da un unico componente eseguibile, 
che dopo la costruzione � presente nella cartella **dist** dell'applicazione. 

### Ambiente di esecuzione 

Ciascuna di queste applicazioni pu� essere eseguita direttamente nell'ambiente 
[developer](../../environments/developer/), sul nodo **dev**. 

### Esecuzione 

Per eseguire un'applicazione: 

1. posizionarsi nella cartella **dist** dell'applicazione - ad esempio `~/projects/asw-810-introduzione/a-chiamata-locale/dist`

2. eseguire lo script `../run-app.sh` 

In alternativa: 

1. posizionarsi nella cartella principale dell'applicazione - ad esempio `~/projects/asw-810-introduzione/a-chiamata-locale`

2. eseguire lo script `dist/run-app.sh` oppure usare il comando `gradle run` 


## L'applicazione distribuita **g-client-server** 

### Build  

Per la costruzione dell'applicazione, vedere le istruzioni 
descritta nella sezione [projects/](../). 

### Componenti eseguibili 

Questa applicazione � composta da due componenti eseguibili (**server** e **client**) 
che dopo la costruzione sono presenti 
nelle cartelle **dist/server** e **dist/client** dell'applicazione. 

### Ambiente di esecuzione 

Questa applicazione va eseguita nell'ambiente 
[client-server](../../environments/client-server/): 
il componente **server** sul nodo **server** e
il componente **client** sul nodo **client**.


### Esecuzione 

Per eseguire questa applicazione si proceda in questo modo: 

1. sul nodo **server** 

   a. posizionarsi nella cartella principale dell'applicazione - in questo caso, `~/projects/asw-810-introduzione/g-client-server`

   b. eseguire lo script `dist/server/run-server.sh` 
   
   c. il server pu� essere arrestato con CTRL-C 

2. sul nodo **client** 

   a. posizionarsi nella cartella principale dell'applicazione - in questo caso, `~/projects/asw-810-introduzione/g-client-server`

   b. eseguire lo script `dist/client/run-client.sh 10.11.1.101` oppure `dist/client/run-client.sh server` (`10.11.1.101` � l'indirizzo IP del nodo **server**) 

