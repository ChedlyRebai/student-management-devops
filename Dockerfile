# FROM  eclipse-temurin:17-jdk-alpine
# WORKDIR /app
# ARG JAR_FILE=target/*.jar

# COPY ${JAR_FILE} /app/app.jar


# CMD ["java", "-jar", "/app/app.jar"]


# FROM  eclipse-temurin:17-jdk-alpine
# WORKDIR /app
# ARG JAR_FILE=target/*.jar

# COPY ${JAR_FILE} /app/app.jar


# CMD ["java", "-jar", "/app/app.jar"]



# FROM maven:3.6.3-openjdk-17-slim AS builder

# WORKDIR /app

# COPY pom.xml .

# RUN mvn dependency:go-offline

# COPY src ./src

# RUN mvn clean package -DskipTests


# FROM eclipse-temurin:17-jdk-alpine

# WORKDIR /app

# COPY --from=builder /app/target/*.jar /app/app.jar

# EXPOSE 8089

# ENTRYPOINT [ "java", "-jar", "app.jar" ]

FROM maven:3.9.6-eclipse-temurin-17-alpine AS builder
WORKDIR /app
COPY pom.xml .

COPY src ./src
RUN mvn clean package -DskipTests


FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# Copy any jar produced by the builder stage into a deterministic name
COPY --from=builder /app/target/*.jar /app/app.jar
EXPOSE 8089

ENTRYPOINT ["java", "-jar", "/app/app.jar"]