FROM ubuntu:20.04

# Install JDK version 17 and required dependencies
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Create a non-root user for running the application
RUN groupadd --gid 10014 choreo && \
    useradd --no-create-home --uid 10014 --gid choreo --shell /usr/sbin/nologin choreouser

# Create necessary directories and set permissions
RUN mkdir -p /app /app/logs /temp && \
    chmod -R 775 /app /temp && \
    chown -R choreouser:choreo /app /temp

# Copy application files
COPY bin /app/bin
COPY conf /app/conf

# Set working directory
WORKDIR /app

# Switch to non-root user
USER 10014

# Expose necessary port
EXPOSE 9743

# Set the entry point
ENTRYPOINT ["/bin/bash", "/app/bin/dashboard.sh"]
