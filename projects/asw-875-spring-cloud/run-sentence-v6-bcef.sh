#!/bin/bash

# Script per avviare l'applicazione Sentence 

echo Running SENTENCE [Eureka + Feign + Hystrix + Zuul Gateway]

echo Starting Eureka Server  
java -Xms64m -Xmx128m -jar b-common-eureka-server/build/libs/common-eureka-server-0.0.1-SNAPSHOT.jar &

echo Starting Word Services [subject + verb + object]
java -Xms64m -Xmx128m -jar -Dspring.profiles.active=subject c-word-service/build/libs/word-0.0.1-SNAPSHOT.jar &
java -Xms64m -Xmx128m -jar -Dspring.profiles.active=verb c-word-service/build/libs/word-0.0.1-SNAPSHOT.jar &
java -Xms64m -Xmx128m -jar -Dspring.profiles.active=object c-word-service/build/libs/word-0.0.1-SNAPSHOT.jar &

echo Starting Sentence Service [using Feign + Hystrix + Zuul]

java -Xms64m -Xmx128m -jar e-sentence-service/build/libs/sentence-0.0.1-SNAPSHOT.jar &

echo Starting Zuul Gateway

java -Xms64m -Xmx128m -jar f-common-zuul-gateway/build/libs/zuul-gateway-0.0.1-SNAPSHOT.jar &
