# Set the base image to Ubuntu
FROM ubuntu

# Update the repository and install necessary tools
RUN apt-get update && \
    apt-get install -y vim wget dialog net-tools && \
    apt-get install -y nginx && \
    rm -v /etc/nginx/nginx.conf && \
    mkdir -p /etc/nginx/logs

# Copy custom Nginx configuration file and sample index.html file
COPY nginx.conf /etc/nginx/
COPY pom.xml /pom.xml
COPY src/main/webapp/index.jsp /www/data/

# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Copy the runner script and make it executable
COPY runner.sh /runner.sh
RUN chmod +x /runner.sh

# Expose port 80
EXPOSE 80

# Set the entry point to run the runner script
ENTRYPOINT ["/runner.sh"]

# Set the default command to execute when creating a new container
CMD ["nginx"]