FROM ubuntu:20.04

# Install JDK version 17 and required dependencies
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/local/java17
ENV PATH=$JAVA_HOME/bin:$PATH

# Create a user for running the application
RUN groupadd --gid 10014 choreo && \
    useradd --no-create-home --uid 10014 --gid choreo --shell /usr/sbin/nologin choreouser

# Copy application files
COPY . /app
WORKDIR /app

USER 10014

EXPOSE 9743
ENTRYPOINT ["/bin/bash", "/app/bin/dashboard.sh"]
