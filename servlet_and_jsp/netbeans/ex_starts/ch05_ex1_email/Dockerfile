# ---- Stage 1: Build WAR with Ant ----
FROM eclipse-temurin:11-jdk AS build
RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*
WORKDIR /app
# copy toàn bộ repo để ant có thể resolve libs, project.properties...
COPY ../../.. /app

# cd đến module ch05 cần build
WORKDIR /app/netbeans/ex_starts/ch05_ex1_email
# NetBeans Ant project thường có target "dist" tạo WAR trong thư mục dist/
RUN ant clean && ant dist

# ---- Stage 2: Run on Tomcat ----
FROM tomcat:9.0-jdk11-temurin
# dọn app mẫu để Tomcat chỉ phục vụ app của bạn
RUN rm -rf /usr/local/tomcat/webapps/*
# copy WAR build được làm ROOT.war để phục vụ ở "/"
COPY --from=build /app/netbeans/ex_starts/ch05_ex1_email/dist/*.war /usr/local/tomcat/webapps/ROOT.war

# Render làm port detection nên không bắt buộc sửa port; Tomcat dùng 8080 là được
EXPOSE 8080
CMD ["catalina.sh", "run"]
