#!/bin/bash

# Script per il rilascio dei componenti per il servizio rest product manager 
# fa solo il redeploy del servizio REST (ma non della base di dati dei prodotti) 

echo "Redeploying Product Manager REST Service"

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

# rest service(s) 
REST_CONTEXT_ROOT=asw/productmanager
# REST_APPLICATION=productmanager 
REST_SERVICE=products 
REST_SERVICE_WAR=product-manager-rest.war 
REST_SERVICE_NAME=ProductManagerRest
REST_SERVICE_URL=http://10.11.1.111:8080/${REST_CONTEXT_ROOT}/${REST_SERVICE}

# determina il path relativo e assoluto in cui si trova lo script 
# (rispetto alla posizione da cui è stata richiesta l'esecuzione dello script) 
REL_PATH_TO_SCRIPT=`dirname $0`
# ABS_PATH_TO_SCRIPT=`( cd ${REL_PATH_TO_SCRIPT} && pwd )`

# base dir 
BD=${REL_PATH_TO_SCRIPT}

LIB_DIR=${BD}/libs

###
echo "Redeploying REST services"

${ASADMIN} undeploy ${REST_SERVICE_NAME} 
${ASADMIN} deploy --name ${REST_SERVICE_NAME} --contextroot ${REST_CONTEXT_ROOT} ${LIB_DIR}/${REST_SERVICE_WAR}

echo "REST services redeployed"


