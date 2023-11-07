# Use an official Apache web server image as the base image
FROM httpd:2.4

# Copy your HTML files to the Apache document root directory
COPY ./index.jsp /usr/local/apache2/htdocs/

# Expose port 80 for web traffic
EXPOSE 80

# Define the startup command
CMD ["httpd-foreground"]
