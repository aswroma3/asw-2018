#!/bin/bash

# Script per l'avvio di Java DB Server 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

# javadb (JAVADB_HOME è una variabile già settata nell'ambiente)

# determina il path relativo e assoluto in cui si trova lo script 
# (rispetto alla posizione da cui è stata richiesta l'esecuzione dello script) 
REL_PATH_TO_SCRIPT=`dirname $0`

DB_HOME=${REL_PATH_TO_SCRIPT}/javadb 

echo "Starting Java DB Server"

mkdir ${DB_HOME}

# non funziona: 
# ${ASADMIN} start-database --dbhome ${JAVADB_HOME}
${ASADMIN} start-database --dbhome ${DB_HOME}

echo "Java DB Server started"
