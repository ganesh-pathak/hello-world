# Stage 1: Build the application
FROM gradle:7.3.3-jdk17 as builder

COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

# Stage 2: Run the application
FROM openjdk:17-jdk-alpine

EXPOSE 8080
RUN mkdir /app
COPY --from=builder /home/gradle/src/build/libs/*.jar /app/spring-app.jar
ENTRYPOINT ["java","-jar","/app/spring-app.jar"]
