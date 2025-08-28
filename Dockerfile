# ---- Stage 1: Build WAR with Ant ----
FROM eclipse-temurin:11-jdk AS build

# Cài đặt Ant để build project
RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*

# Copy toàn bộ source code vào container
WORKDIR /app
COPY . /app

# Build với Ant (sẽ tạo file WAR trong dist/)
RUN ant clean && ant dist

# ---- Stage 2: Run trên Tomcat ----
FROM tomcat:9.0-jdk11-temurin

# Xoá các webapps mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR đã build vào Tomcat và rename thành ROOT.war
COPY --from=build /app/dist/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
