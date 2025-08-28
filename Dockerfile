# ---- Stage 1: Build with Ant ----
FROM openjdk:8-jdk AS build

WORKDIR /app

# Install Ant + wget
RUN apt-get update && apt-get install -y ant wget && rm -rf /var/lib/apt/lists/*

# Copy project
COPY . /app

# Tạo thư mục lib và tải servlet-api.jar (chỉ để compile)
RUN mkdir -p lib && \
    wget -O lib/servlet-api.jar https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar

# Build với Ant
RUN ant clean && ant dist

# ---- Stage 2: Run with Tomcat ----
FROM tomcat:9-jdk11-openjdk

# Copy WAR sang Tomcat
COPY --from=build /app/dist/WebC5.war /usr/local/tomcat/webapps/WebC5.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
