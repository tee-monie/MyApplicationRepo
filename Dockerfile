FROM maven:3.8.4 AS build

WORKDIR /MyWebApp
COPY MyWebApp/pom.xml .
COPY MyWebApp/src ./src

RUN mvn clean package

FROM tomcat:latest

RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR file from the previous stage
COPY --from=build /MyWebApp/target/MyWebApp.war /usr/local/tomcat/webapps/ROOT.war

# Expose the port your web app will run on
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
