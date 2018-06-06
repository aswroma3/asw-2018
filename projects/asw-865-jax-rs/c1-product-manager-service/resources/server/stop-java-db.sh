#!/bin/bash

# Script per l'arresto di Java DB Server 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

echo "Stopping Java DB Server"

${ASADMIN} stop-database

echo "Java DB Server stopped"
