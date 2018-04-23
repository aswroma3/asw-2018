#!/bin/bash

# Script per elencare le risorse JMS disponibili 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

echo Listing JMS resources 

${ASADMIN} list-jms-resources 

