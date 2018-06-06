#!/bin/bash

# Script per il rilascio del servizio rest product manager: 
# crea la base di dati dei prodotti e rilascia il componente per il servizio rest 

echo "Deploying Product Manager REST Service"

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

# jdbc 
JDBC_CONNECTION_POOL=product_db_derby_pool
JDBC_DATA_SOURCE=jdbc/ProductDB

# javadb (JAVADB_HOME � una variabile gi� settata nell'ambiente)
EXEC_SQL=${JAVADB_HOME}/bin/ij 

# libraries 
# ASW_UTIL_JAR=asw-util.jar 

# rest service(s) 
REST_CONTEXT_ROOT=asw/productmanager
# REST_APPLICATION=productmanager 
REST_SERVICE=products 
REST_SERVICE_WAR=product-manager-rest.war 
REST_SERVICE_NAME=ProductManagerRest
REST_SERVICE_URL=http://10.11.1.111:8080/${REST_CONTEXT_ROOT}/${REST_SERVICE}

# determina il path relativo e assoluto in cui si trova lo script 
# (rispetto alla posizione da cui � stata richiesta l'esecuzione dello script) 
REL_PATH_TO_SCRIPT=`dirname $0`
# ABS_PATH_TO_SCRIPT=`( cd ${REL_PATH_TO_SCRIPT} && pwd )`

# base dir 
BD=${REL_PATH_TO_SCRIPT}

LIB_DIR=${BD}/libs

###
echo "Creating JDBC resources for the service"

${ASADMIN} create-jdbc-connection-pool --datasourceclassname org.apache.derby.jdbc.ClientDataSource --restype javax.sql.XADataSource --property portNumber=1527:password=APP:user=APP:serverName=10.11.1.111:databaseName=product-db:connectionAttributes=\;create\\=true ${JDBC_CONNECTION_POOL}
# asadmin list-jdbc-connection-pools
# asadmin get resources.jdbc-connection-pool.${JDBC_CONNECTION_POOL}.property

# una jdbc-resource � il nome "tecnico" per data source 
${ASADMIN} create-jdbc-resource --connectionpoolid ${JDBC_CONNECTION_POOL} ${JDBC_DATA_SOURCE}
# asadmin list-jdbc-resources

echo "JDBC resources for the service created"

###
echo "Creating ProductDB"

${EXEC_SQL} ${BD}/sql/create-and-load.sql 

echo "ProductDB created"

###
# echo "Deploying libraries"
# ${ASADMIN} add-library --type app ${LIB_DIR}/${ASW_UTIL_JAR} 
# echo "Libraries for the service deployed"

###
echo "Deploying REST services"

${ASADMIN} deploy --name ${REST_SERVICE_NAME} --contextroot ${REST_CONTEXT_ROOT} ${LIB_DIR}/${REST_SERVICE_WAR}

echo "REST services deployed"


