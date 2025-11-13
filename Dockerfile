FROM tomcat:9.0.98-jdk17

EXPOSE 8080
RUN rm -rf /usr/local/tomcat/webapps/*
COPY target/petclinic.war /usr/local/tomcat/webapps/ROOT.war
ENTRYPOINT ["catalina.sh", "run"]
