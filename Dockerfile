# Step 1: Use a Maven image to build the application
FROM maven:3.8.5-openjdk-17 AS builder

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy the Maven project files into the container
COPY pom.xml .
COPY src ./src

# Step 4: Build the application
RUN mvn clean package -DskipTests

# Step 5: Use a lightweight JDK image for runtime
FROM openjdk:17-jdk-slim

# Step 6: Set the working directory in the runtime container
WORKDIR /app

# Step 7: Copy the built JAR file from the builder stage
COPY --from=builder /app/target/*.jar rest-http.jar

# Step 8: Expose the port your application runs on
EXPOSE 8080

# Step 9: Define the command to run the application
CMD ["java", "-jar", "rest-http.jar"]
