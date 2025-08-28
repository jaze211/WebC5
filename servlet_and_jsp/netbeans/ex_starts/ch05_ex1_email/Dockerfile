# ---- Stage 1: Build WAR with Ant ----
FROM eclipse-temurin:11-jdk AS build

RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*

WORKDIR /app
# Copy toàn bộ project (ch05_ex1_email) vào /app
COPY . /app

# build với Ant (sẽ sinh WAR trong dist/)
RUN ant clean && ant dist

# ---- Stage 2: Run on Tomcat ----
FROM tomcat:9.0-jdk11-temurin
RUN rm -rf /usr/local/tomcat/webapps/*

# copy WAR đã build sang Tomcat làm ROOT.war
COPY --from=build /app/dist/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
