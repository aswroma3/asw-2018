#!/bin/bash

# Script per la rimozione dell'EJB 

echo Undeploying hello EJB 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

EJB_INTERFACE_JAR=hello-ejb-interface.jar 
EJB_IMPL_JAR=hello-ejb-impl.jar 
EJB_NAME=Hello 

${ASADMIN} undeploy ${EJB_NAME} 
${ASADMIN} remove-library --type app ${EJB_INTERFACE_JAR}



