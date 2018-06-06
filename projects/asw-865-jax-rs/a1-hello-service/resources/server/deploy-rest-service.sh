#!/bin/bash

# Script per il rilascio del servizio rest 

echo Deploying hello rest service 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

REST_CONTEXT_ROOT=asw/hellorest
# REST_APPLICATION=hello 
REST_SERVICE=hello 
REST_SERVICE_WAR=${REST_SERVICE}.war 
REST_SERVICE_NAME=HelloRest

# URL del servizio  
# REST_SERVICE_URL=http://10.11.1.111:8080/${REST_CONTEXT_ROOT}/${REST_APPLICATION}/${REST_SERVICE}
REST_SERVICE_URL=http://10.11.1.111:8080/${REST_CONTEXT_ROOT}/${REST_SERVICE}

# determina il path relativo e assoluto in cui si trova lo script 
# (rispetto alla posizione da cui � stata richiesta l'esecuzione dello script) 
REL_PATH_TO_SCRIPT=`dirname $0`
# ABS_PATH_TO_SCRIPT=`( cd ${REL_PATH_TO_SCRIPT} && pwd )`

# base dir 
BD=${REL_PATH_TO_SCRIPT}

LIB_DIR=${BD}/libs

${ASADMIN} deploy --name ${REST_SERVICE_NAME} --contextroot ${REST_CONTEXT_ROOT} ${LIB_DIR}/${REST_SERVICE_WAR}

echo "Il servizio rest ${REST_SERVICE} e' stato rilasciato su ${REST_SERVICE_URL}"


