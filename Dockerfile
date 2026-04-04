FROM openjdk
WORKDIR /usr/local/tomcat/webapps/
COPY *.jar ./application.jar
EXPOSE 8080
CMD ["java", "-jar","application.jar"]