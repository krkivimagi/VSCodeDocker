# Use the VS Code Dev Container image as the base
FROM mcr.microsoft.com/vscode/devcontainers/base:debian

# Set a working directory
WORKDIR /home/vscode

# Install Visual Studio Code
RUN wget 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' -O /tmp/code_latest_amd64.deb \
    && apt-get update \
    && apt-get install -y /tmp/code_latest_amd64.deb \
    && rm -f /tmp/code_latest_amd64.deb \
    && rm -rf /var/lib/apt/lists/*

# Add Microsoft package signing key and repository for .NET
RUN wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb

# Install .NET SDK 7.0, Node.js and npm
RUN apt-get update && \
    apt-get install -y \
    dotnet-sdk-7.0 \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Clean up any apt cache to reduce image size
RUN apt-get clean


# Expose ports (if necessary, e.g., for web applications)
EXPOSE 8080

# Set default command for container to keep it running
CMD ["tail", "-f", "/dev/null"]


# INSTRUCTIONS TO BUILD THE CONTAINERS:
# Open terminal in the folder where Dockerfile and docker compose.yml are
# Command to build docker compose.yml
# docker compose up

# INSTRUCTIONS:
# After using compose up in the folder containing docker-compose.yml it will build the containers
# Then we can open VSCode and make sure it has the extensions: docker; dev containers
# Then in VSCode, docker Tab, right click on Containers-vscodedocker-vscode-container and attach Visual Studio Code.

# Command to stop containers
# docker compose down

# Command to stop docker compose env and remove local image
# docker compose down --rmi local

# EXTRA: to build only dockerfile (dev env)
# Command to build image
# docker build -t vscode-container .

# Command to run the image
# docker run -it --rm --init vscode-container