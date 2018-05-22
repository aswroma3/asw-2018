#!/bin/bash

# Script per avviare l'applicazione Lucky word 

echo Running LUCKY WORD 

echo Starting Config Server  
java -Xms64m -Xmx128m -jar a1-common-config-server/build/libs/common-config-server-0.0.1-SNAPSHOT.jar &

echo Waiting for the Config Server  
sleep 30 

echo Starting Lucky Word
java -Xms64m -Xmx128m -jar a2-lucky-word-cloud-config-client/build/libs/lucky-word-0.0.1-SNAPSHOT.jar &
