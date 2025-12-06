# Stage 1: Build WAR bằng Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copy cấu hình Maven trước để cache dependency
COPY pom.xml .
RUN mvn -q -e -DskipTests dependency:go-offline

# Copy source code
COPY src ./src

# Build WAR (bỏ qua test)
RUN mvn -q -DskipTests package

# Stage 2: Chạy trên Tomcat
FROM tomcat:10.1-jdk17

# Xóa webapps mặc định
RUN rm -rf /usr/local/tomcat/webapps/*

# ⚠️ Đường dẫn WAR: chỉnh theo artifactId & version trong pom.xml
# Nếu pom.xml của bạn là:
#   <groupId>...</groupId>
#   <artifactId>ass2</artifactId>
#   <version>1.0-SNAPSHOT</version>
# thì tên file sẽ là ass2-1.0-SNAPSHOT.war (đúng như bạn đã dùng)
COPY --from=build /app/target/ass2-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
