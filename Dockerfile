# Stage 1: Build the app using Maven
FROM maven:3.9.6-eclipse-temurin-17 as builder

WORKDIR /app

# Copy pom and source
COPY pom.xml .
COPY src ./src

# Build the project
RUN mvn clean package -DskipTests

# Stage 2: Run the Spring Boot app
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy built jar from builder stage
COPY --from=builder /app/target/demo-workshop-2.0.2.jar app.jar

# Expose port (change if needed)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
