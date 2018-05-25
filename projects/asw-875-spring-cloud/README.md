# asw-885-spring-cloud

Questo progetto contiene alcune applicazioni 
che esemplificano l'uso di [Spring Cloud](http://projects.spring.io/spring-cloud/) 
per la realizzazione di applicazioni *multi-servizi*. 

Gli esempi sono relativi a due applicazioni principali: 

* l'applicazione **lucky-word**, mostrata in pi� versioni 

* l'applicazione **sentence**, mostrata in pi� versioni 


### Applicazione **lucky-word**

L'applicazione **lucky-word** � formata da due servizi: 

* **a1-common-config-server** � un configuration server (Spring Cloud Config) 

* **a2-lucky-word-cloud-config-client** � invece l'applicazione web, che accede come client al configuration server 

Per eseguire questa applicazione, bisogna costruire e avviare i due servizi, come di consueto per le applicazioni Spring Boot. 

Inoltre, al posto di **a2-lucky-word-cloud-config-client** 
� possibile utilizzare l'applicazione **a3-lucky-word-cloud-config-client-refresh**, 
in cui � abilitato il refresh dinamico della configurazione. 


### Applicazione **sentence**

L'applicazione **sentence** � invece formata da pi� servizi, e realizzata in pi� versioni (alcune delle quali condividono gli stessi servizi): 
  
* **b-common-eureka-server** � un discovery server (Eureka), da usare in tutte le versioni dell'applicazione  

* **c-word-service** � il servizio per la generazione di parole casuali, da usare in tutte le versioni dell'applicazione  

* **d1-sentence-service-discovery** � una versione del servizio per la generazione delle frasi, che utilizza solo il service discovery Eureka 

* **d2-sentence-service-ribbon** � una versione del servizio per la generazione delle frasi, che utilizza il load balancer lato client Ribbon 

* **d3-sentence-service-feign** � una versione del servizio per la generazione delle frasi, che utilizza il client REST basato su Feign 

* **d4-sentence-service-hystrix** � una versione del servizio per la generazione delle frasi, che utilizza Hystrix come circuit breaker 

* **d5-sentence-service-zuul** � una versione del servizio per la generazione delle frasi, che utilizza Zuul come API gateway 

* **e-sentence-service** � un'altra versione del servizio per la generazione delle frasi (richiede un gateway) 

* **f-common-zuul-gateway** � un gateway basato su Zuul per accedere al servizio delle frasi 

Per eseguire questa applicazione, bisogna costruire i diversi servizi, come di consueto, 
e poi avviarli (di solito vengono forniti degli script per l'avvio dei singoli servizi). 

I servizi che possono essere utilizzati in modo congiunto sono: 

* certamente va usata un'istanza di **b-common-eureka-server**  

* certamente vanno usate almeno tre istanze di **c-word-service**, ed almeno una per ogni tipo di parola 

* poi � possibile usare uno (ed una sola istanza) tra i servizi **d**: 
  **d1-sentence-service-discovery**, **d2-sentence-service-ribbon**, **d3-sentence-service-feign**, 
  **d4-sentence-service-hystrix** oppure **d5-sentence-service-zuul** 
  
* in alternativa ai servizi **d**, � possibile usare una o pi� istanze 
  di un servizio **e-sentence-service** insieme al servizio **f-common-zuul-gateway**
 

### Build  

Per la costruzione di ciascuna applicazione, vedere le istruzioni 
descritte nella sezione [projects/](../). 

In pratica, per compilare e assemblare ciascuna applicazione, bisogna 

1. posizionarsi nella cartella principale dell'applicazione di interesse - ad esempio `~/projects/asw-885-spring-cloud/a1-common-config-server`

2. per compilare e assemblare l'applicazione, usare il comando `gradle build` 


### Ambiente di esecuzione 

Ciascuna di queste applicazioni pu� essere eseguita direttamente nell'ambiente 
[developer](../../environments/developer/), sul nodo **dev**. 
In questo modo, le applicazioni web che espongono servizi alla porta **8080** del nodo **dev** 
vengono anche pubblicate sulla porta **8088** dell'host. 

Si suggerisce per� di modificare la configurazione del nodo **dev**
dell'ambiente [developer](../../environments/developer/)
assegnandogli una quantit� maggiore di risorse. Ad esempio: `v.cpus = 2` e `v.memory = 4096`


### Esecuzione 

Per eseguire un'applicazione, bisogna avviare individualmente i servizi che la compongono, 
usando gli script forniti con i singoli servizi oppure il comando `gradle bootRun`. 

In alternativa, � possibile usare gli script *di esempio* nella cartella principale del progetto. 

**Attenzione**: l'applicazione *sentence* ci mette qualche minuto a partire. 


Lo script `kill-java-processes.sh` consente di terminare tutte le applicazioni Java in esecuzione 
(**da usare con cautela!**). 
