#!/bin/bash

# Script per la rimozione dell'EJB 

echo Undeploying asynchronous EJB 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

EJB_INTERFACE_JAR=asynchronous-ejb-interface.jar 
EJB_IMPL_JAR=asynchronous-ejb-impl.jar 
EJB_NAME=AsynchronousBean 
# ASW_UTIL_JAR=asw-util.jar 

${ASADMIN} undeploy ${EJB_NAME} 
${ASADMIN} remove-library --type app ${EJB_INTERFACE_JAR}
# asadmin remove-library --type app ${ASW_UTIL_JAR}



