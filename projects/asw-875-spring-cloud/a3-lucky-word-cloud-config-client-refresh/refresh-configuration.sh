#!/bin/bash

# effettua il refresh della configurazione  

curl -X POST http://localhost:8080/actuator/refresh/ 

# esempio: 
# 1) avvia l'applicazione senza aver avviato il config server 
# 2) esegui il client -> Default 
# 3) avvia il config server 
# 4) effettua il refresh (con questo script) 
# 5) esegui il client -> Evviva 

# nota: bisogna aver configurato l'actuator e l'endpoint refresh 


