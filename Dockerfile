# ---- Stage 1: Build WAR with Ant ----
FROM eclipse-temurin:11-jdk AS build

# Cài Ant
RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*

# Đặt thư mục làm việc trong container
WORKDIR /app

# Copy toàn bộ project (ch05_ex1_email) vào container
COPY . /app

# Build với Ant (sẽ sinh WAR trong dist/)
RUN ant clean && ant dist

# ---- Stage 2: Run on Tomcat ----
FROM tomcat:9.0-jdk11-temurin

# Xóa webapps mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR đã build sang Tomcat và rename thành ROOT.war
COPY --from=build /app/dist/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
