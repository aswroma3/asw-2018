#!/bin/bash

# SScript per avviare diverse istanze del servizio word (una per tipo di parola)

echo Running SUBJECT, VERB, and OBJECT WORD services 

java -Xms64m -Xmx128m -jar -Dspring.profiles.active=subject build/libs/word-0.0.1-SNAPSHOT.jar &
java -Xms64m -Xmx128m -jar -Dspring.profiles.active=verb build/libs/word-0.0.1-SNAPSHOT.jar &
java -Xms64m -Xmx128m -jar -Dspring.profiles.active=object build/libs/word-0.0.1-SNAPSHOT.jar &

