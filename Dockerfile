# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-alpine

# Set the working directory
WORKDIR /app

# Copy the built JAR file (adjust the path as needed)
COPY target/demo-workshop-2.0.2.jar app.jar

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
