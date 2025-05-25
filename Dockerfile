# Stage 1: Build the application using Maven and JDK 21
FROM maven:3.9.6-eclipse-temurin-21 AS build

WORKDIR /app

# Cache dependencies first
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy all project files
COPY . .

# Build the app, skipping tests
RUN mvn clean package -DskipTests

# Stage 2: Run the application with a JDK 21 image
FROM eclipse-temurin:21-jdk

WORKDIR /app
EXPOSE 8080

# Copy the built JAR from build stage
COPY --from=build /app/target/*.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
