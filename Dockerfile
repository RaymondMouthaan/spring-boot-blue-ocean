FROM amd64/openjdk:11-jre-slim

RUN sh -c 'ls -al /tmp'

COPY ./target/spring-boot-demo-0.0.1-SNAPSHOT.jar app.jar
RUN sh -c 'touch /app.jar'

EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
