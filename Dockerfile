FROM gradle:jdk17 as builder

COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

FROM openjdk:17-ea-slim

EXPOSE 8080
RUN mkdir /app
COPY --from=builder /home/gradle/src/build/libs/hello-world-0.0.1-SNAPSHOT.jar /app/hello-world.jar
ENTRYPOINT ["java","-jar","/app/hello-world.jar"]
