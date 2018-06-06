#!/bin/bash

# Script per ri-creare la base di dati dei prodotti 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

# javadb (JAVADB_HOME è una variabile già settata nell'ambiente)
EXEC_SQL=${JAVADB_HOME}/bin/ij 

# determina il path relativo e assoluto in cui si trova lo script 
# (rispetto alla posizione da cui è stata richiesta l'esecuzione dello script) 
REL_PATH_TO_SCRIPT=`dirname $0`
# ABS_PATH_TO_SCRIPT=`( cd ${REL_PATH_TO_SCRIPT} && pwd )`

# base dir 
BD=${REL_PATH_TO_SCRIPT}

LIB_DIR=${BD}/libs

###
echo "Re-creating ProductDB"

${EXEC_SQL} ${BD}/sql/drop.sql 
${EXEC_SQL} ${BD}/sql/create-and-load.sql 

echo "ProductDB re-created"

