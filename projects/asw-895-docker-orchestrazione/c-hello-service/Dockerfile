############################################
# Dockerfile per l'applicazione hello 
############################################

FROM frolvlad/alpine-oraclejdk8 

ADD build/libs/hello-0.0.1-SNAPSHOT.jar hello.jar

EXPOSE 8080

ENTRYPOINT ["/usr/bin/java", "-Xmx128m", "-Xms128m"]

CMD ["-jar", "hello.jar"]
