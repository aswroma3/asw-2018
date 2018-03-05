#!/bin/bash

# Script per l'avvio dell'app che utilizza il servizio Service  
# Per la versione dell'applicazione basata su Spring 
# (e il plugin distribution di Gradle)

echo Running my app 

# determina il path relativo in cui si trova lo script 
# (rispetto alla posizione da cui � stata richiesta l'esecuzione dello script) 
PATH_TO_SCRIPT=`dirname $0`

exec ${PATH_TO_SCRIPT}/app/bin/app 

