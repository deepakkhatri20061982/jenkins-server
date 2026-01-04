FROM python:3.10-slim

# Install system dependencies + Java 21 runtime
RUN apt-get update && apt-get install -y \
    openjdk-21-jdk-headless \
    git \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Jenkins
RUN curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key \
    | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

RUN echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/" \
    > /etc/apt/sources.list.d/jenkins.list

RUN apt-get update && apt-get install -y jenkins

# Create Python virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip
RUN pip install --upgrade pip

# Install Python dependencies
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Expose Jenkins ports
EXPOSE 8080 50000

# Start Jenkins
CMD ["java", "-jar", "/usr/share/java/jenkins.war"]
