#!/bin/bash

# Script per la rimozione dell'EJB 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

echo Undeploying session counter EJB 

EJB_INTERFACE_JAR=session-counter-ejb-interface.jar 
EJB_IMPL_JAR=session-counter-ejb-impl.jar 
EJB_NAME=SessionCounter 

${ASADMIN} undeploy ${EJB_NAME} 
${ASADMIN} remove-library --type app ${EJB_INTERFACE_JAR}



