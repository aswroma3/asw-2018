#!/bin/bash

# Script per l'avvio di GlassFish. 
# (L'avvio viene richiesto solo se il dominio non è già avviato). 
# Funziona sia con Glassfish Oracle 4.1.2 e 5.0, che con Payara 4.1.2. 

echo Starting GlassFish service 

# prova ad avviare il dominio 
asadmin start-domain

if [ $? -eq 0 ]
then 
    echo "GlassFish started"
else 
    echo "GlassFish is already running"
fi 

exit 0 
