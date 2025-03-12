# SBBS Docker Setup

This project allows you to quickly set up and run the SBBS (Simple Bulletin Board System) application using Docker. SBBS is a Telnet-based application that operates on port 23.

## Requirements

- [Docker](https://www.docker.com/get-started) (v20.10 and above)
- [Docker Compose](https://docs.docker.com/compose/install/) (v1.27.0 and above)

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/oytunistrator/sbbs-docker.git
   cd sbbs-docker
   ```

2. **Build the Docker image:**

   Build the Docker image with the following command:

   ```bash
   docker build . -t sbbs
   ```

3. **Start the services with Docker Compose:**

   Start all services with Docker Compose:

   ```bash
   docker-compose up -d
   ```

4. **Access SBBS via Telnet:**

   Once the SBBS application is running, you can access it via Telnet:

   ```bash
   telnet localhost 23
   ```

   If you're using a different port, you can adjust the settings in the `docker-compose.yml` file.

## Managing Containers

- **Start the containers:**

   ```bash
   docker-compose up -d
   ```

- **Stop the containers:**

   ```bash
   docker-compose down
   ```

This should be a clear and concise README for your Telnet-based SBBS application!
