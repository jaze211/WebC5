# ---- Stage 1: Build with Ant ----
FROM openjdk:8-jdk AS build

WORKDIR /app

# Install Ant
RUN apt-get update && apt-get install -y ant wget

# Download servlet API (for compilation)
RUN mkdir lib && \
    wget -O lib/servlet-api.jar https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar

# Copy project files
COPY . /app

# Build with Ant
RUN ant clean && ant dist

# ---- Stage 2: Run with Tomcat ----
FROM tomcat:9-jdk11-openjdk

COPY --from=build /app/dist/ch05_ex1_email.war /usr/local/tomcat/webapps/ch05_ex1_email.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
