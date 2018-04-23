#!/bin/bash

# Script per la rimozione delle risorse JMS per le applicazioni asw840 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

QUEUENAME=jms/asw/Queue
TOPICNAME=jms/asw/Topic
CFNAME=jms/asw/ConnectionFactory

echo Deleting JMS resources for asw840

${ASADMIN} delete-jms-resource ${QUEUENAME} 

${ASADMIN} delete-jms-resource ${TOPICNAME} 

${ASADMIN} delete-jms-resource ${CFNAME} 

echo JMS resources for asw840 deleted
