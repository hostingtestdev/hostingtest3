# Fetching latest version of Java
#FROM openjdk:17-alpine

# Setting up work directory
#WORKDIR /app

# Copy the jar file into our app
#COPY ./target/hostingtest1-0.0.1-SNAPSHOT.jar /app
#COPY * /app

# Exposing port 8080
#EXPOSE 8080

# Starting the application
#CMD ["java", "-jar", "hostingtest1-0.0.1-SNAPSHOT.jar"]


#
# Build stage
#
FROM maven:3.8.3-openjdk-17 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:17-alpine
COPY --from=build /home/app/target/hostingtest1-0.0.1-SNAPSHOT.jar /usr/local/lib/demo.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/hostingtest1-0.0.1-SNAPSHOT.jar"]
