# Stage 1: Build the jar using Maven
FROM maven:3.8.5-openjdk-17 AS build

WORKDIR /app

# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the project and package jar (skip tests for speed)
RUN mvn clean package -DskipTests

# Stage 2: Run the jar
FROM openjdk:17-jdk-alpine

WORKDIR /app

# Copy the jar from the build stage
COPY --from=build /app/target/demo-workshop-2.0.2.jar app.jar

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
