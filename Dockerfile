# 🔧 Stage 1: Build the application using Maven and JDK 1.8
FROM maven:3.6.3-openjdk-8 AS build

# Set working directory
WORKDIR /app

# Cache dependencies (makes rebuilds faster)
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the full source code and build
COPY . .
RUN mvn clean package -DskipTests

# 🏗️ Stage 2: Run the application on a lightweight image
FROM openjdk:8-jdk-slim

# Set working directory
WORKDIR /app

# Expose port
EXPOSE 8080

# Copy the built JAR from previous stage
COPY --from=build /app/target/GemAI-0.0.1-SNAPSHOT.jar app.jar

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
