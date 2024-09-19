FROM tomcat:8.0-alpine
EXPOSE 8080
COPY target/maven-web-app.war /usr/local/tomcat/webapps/maven-web-app.war
CMD ["catalina.sh","run"]
