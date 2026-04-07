ARG base=eclipse-temurin
ARG version=17-jre-alpine
FROM ${base}:${version}
ARG path=/app
WORKDIR ${path}
COPY target/*.jar /app.jar
EXPOSE 8080
CMD ["java", "-jar" , "app.jar"]                    
