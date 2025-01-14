FROM amazoncorretto:17.0.13-al2023 AS build_img
RUN dnf update -y && \
    dnf install -y maven git && \
    dnf clean all

# Clone the repository and build the project
WORKDIR /app
RUN git clone https://github.com/Ritik-Saxena/PetClinic-DevOps-CICD.git && \
    ls -R && \
    cd PetClinic-DevOps-CICD && \
    mvn clean install

# Use Tomcat for hosting the application
FROM tomcat:9.0.98-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build_img /app/PetClinic-DevOps-CICD/Petclinic/target/petclinic.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 and start Tomcat
EXPOSE 8080
ENTRYPOINT ["catalina.sh", "run"]




# FROM tomcat:9.0.98-jdk17

# EXPOSE 8080
# RUN rm -rf /usr/local/tomcat/webapps/*
# COPY target/petclinic.war /usr/local/tomcat/webapps/ROOT.war
# ENTRYPOINT ["catalina.sh", "run"]
