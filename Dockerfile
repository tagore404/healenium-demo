# Stage 1: Build the application
FROM maven:3.9.2-eclipse-temurin-17 AS build

WORKDIR /app

# Copy pom.xml and download dependencies first for caching
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source code
COPY src ./src

# Build the project (without skipping tests, or you can skip them)
RUN mvn clean package -DskipTests

# Stage 2: Run the jar using a lightweight JRE image
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /app/target/demo-workshop-2.0.2.jar app.jar

# Expose the port your Spring Boot app uses (default 8080)
EXPOSE 8080

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
