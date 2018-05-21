#!/bin/bash

# Script per l'avvio dell'application client message-consumer  

APPNAME=message-consumer

echo Running application client ${APPNAME} 

# determina il path relativo in cui si trova lo script 
# (rispetto alla posizione da cui � stata richiesta l'esecuzione dello script) 
# PATH_TO_SCRIPT="`dirname \"$0\"`"
PATH_TO_SCRIPT=`dirname $0`

# $@ vuol dire che i parametri dello script sono passati all'appclient 
appclient -client ${PATH_TO_SCRIPT}/libs/${APPNAME}.jar $@
# appclient -xml ${PATH_TO_SCRIPT}/glassfish-acc.xml -client ${PATH_TO_SCRIPT}/libs/${APPNAME}.jar $@
