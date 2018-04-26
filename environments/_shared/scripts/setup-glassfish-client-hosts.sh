#!/bin/bash

# funziona con Glassfish Oracle 4, Oracle 5 e Payara 4 

HOSTS_FILE=/etc/hosts 
ENTRY_TO_ADD="10.11.1.111	glassfish"

echo "setup glassfish client /etc/hosts file"

# aggiunge "10.11.1.111 glassfish" a /etc/hosts 
echo "modifying /etc/hosts file"
echo "adding ${ENTRY_TO_ADD}"
echo "${ENTRY_TO_ADD}" >> ${HOSTS_FILE}
