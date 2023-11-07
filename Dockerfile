# Use a base image with the Tomcat server installed
FROM tomcat:latest

# Remove the default Tomcat ROOT webapp
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your index.jsp file to Tomcat's webapps/ROOT directory
COPY ./MyWebApp/src/main/webapp/index.html /usr/local/tomcat/webapps/ROOT/

# Expose port 8080 for Tomcat
EXPOSE 8080

# Start Tomcat as the entry point
CMD ["catalina.sh", "run"]

