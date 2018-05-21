#!/bin/bash

# Script per la rimozione dell'EJB 

echo Undeploying stateless counter EJB 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

EJB_INTERFACE_JAR=stateless-counter-ejb-interface.jar 
EJB_IMPL_JAR=stateless-counter-ejb-impl.jar 
EJB_NAME=StatelessCounter 

${ASADMIN} undeploy ${EJB_NAME} 
${ASADMIN} remove-library --type app ${EJB_INTERFACE_JAR}



