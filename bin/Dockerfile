FROM eclipse-temurin:25-jre-noble
ARG path=/usr/local/tomcat/webapps
WORKDIR ${path}
COPY target/*.war ${path}/app.war
EXPOSE 8080
CMD ["catalina.sh" , "run"]