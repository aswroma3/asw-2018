#!/bin/bash

# Script per la rimozione dell'EJB 

echo Undeploying calculator EJB 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

EJB_INTERFACE_JAR=calculator-ejb-interface.jar 
EJB_IMPL_JAR=calculator-ejb-impl.jar 
EJB_NAME=Calculator 

${ASADMIN} undeploy ${EJB_NAME} 
${ASADMIN} remove-library --type app ${EJB_INTERFACE_JAR}



