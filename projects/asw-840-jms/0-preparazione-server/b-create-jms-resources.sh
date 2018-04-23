#!/bin/bash

# Script per la creazione delle risorse JMS per le applicazioni asw840 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

QUEUENAME=jms/asw/Queue
TOPICNAME=jms/asw/Topic
CFNAME=jms/asw/ConnectionFactory

echo Creating JMS resources for asw840

${ASADMIN} create-jms-resource --restype javax.jms.Queue --enabled=true ${QUEUENAME} 

${ASADMIN} create-jms-resource --restype javax.jms.Topic --enabled=true ${TOPICNAME} 

${ASADMIN} create-jms-resource --restype javax.jms.ConnectionFactory --enabled=true ${CFNAME} 

echo JMS resources for asw840 created
