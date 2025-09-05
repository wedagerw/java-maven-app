FROM openjdk:17-jdk-slim
WORKDIR /app
COPY . .
RUN ./mvnw package
CMD ["java", "-jar", "target/demo-1.0.0.jar"]
