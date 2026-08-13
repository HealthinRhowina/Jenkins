FROM eclipse-temurin:17-jre

COPY target/demo-1.0.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]