ARG base=openjdk
ARG version=17-jre-slim
FROM ${base}:${version}
ARG path=/app
WORKDIR ${path}
COPY target/*.jar /app.jar
EXPOSE 8080
CMD ["java", "-jar" , "app.jar"]                    
