# Use an official Tomcat image as the base image
FROM tomcat:9-jre11

# Remove the default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your web application (WAR file) into Tomcat's webapps directory
COPY index.jsp /usr/local/tomcat/webapps/

# Expose port 8080 for Tomcat
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
