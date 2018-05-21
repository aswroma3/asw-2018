#!/bin/bash

# Script per il rilascio dell'EJB 

echo Deploying asynchronous EJB 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

EJB_INTERFACE_JAR=asynchronous-ejb-interface.jar 
EJB_IMPL_JAR=asynchronous-ejb-impl.jar 
EJB_NAME=AsynchronousBean 
# ASW_UTIL_JAR=asw-util.jar 

# determina il path relativo e assoluto in cui si trova lo script 
# (rispetto alla posizione da cui è stata richiesta l'esecuzione dello script) 
REL_PATH_TO_SCRIPT=`dirname $0`
# ABS_PATH_TO_SCRIPT=`( cd ${REL_PATH_TO_SCRIPT} && pwd )`

# base dir 
BD=${REL_PATH_TO_SCRIPT}

LIB_DIR=${BD}/libs

${ASADMIN} add-library --type app ${LIB_DIR}/${EJB_INTERFACE_JAR}
# asadmin add-library --type app ${LIB_DIR}/${ASW_UTIL_JAR}
# asadmin deploy --name ${EJB_NAME} --libraries ${EJB_INTERFACE_JAR},${ASW_UTIL_JAR} ${LIB_DIR}/${EJB_IMPL_JAR}
${ASADMIN} deploy --name ${EJB_NAME} --libraries ${EJB_INTERFACE_JAR} ${LIB_DIR}/${EJB_IMPL_JAR}


