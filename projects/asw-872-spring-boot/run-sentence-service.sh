#!/bin/bash

# Script per avviare l'applicazione Sentence 

echo Running SENTENCE [words + sentence]

echo Starting Word Services [subject + verb + object]
java -Xms64m -Xmx128m -jar -Dspring.profiles.active=subject l1-word-service/build/libs/word-0.0.1-SNAPSHOT.jar &
java -Xms64m -Xmx128m -jar -Dspring.profiles.active=verb l1-word-service/build/libs/word-0.0.1-SNAPSHOT.jar &
java -Xms64m -Xmx128m -jar -Dspring.profiles.active=object l1-word-service/build/libs/word-0.0.1-SNAPSHOT.jar &

echo Starting Sentence Service
java -Xms64m -Xmx128m -jar l2-sentence-service/build/libs/sentence-0.0.1-SNAPSHOT.jar &

