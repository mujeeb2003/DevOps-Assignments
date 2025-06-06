# License Manager

## Task 1

### Overview

License Manager is a comprehensive software solution designed to streamline and automate the process of managing software licenses for organizations. This project aims to simplify license tracking, reduce compliance risks, and optimize software asset management.

### Features

-   **License Tracking**: Easily monitor and manage all software licenses in one centralized platform.
-   **Compliance Management**: Ensure adherence to licensing agreements and reduce the risk of non-compliance.
-   **Usage Analytics**: Gain insights into software usage patterns to make informed decisions about license allocation.
-   **Automated Notifications using cron job**: Set up automatic reminders for license notifications to avoid service interruptions.
-   **User Management**: Efficiently assign and revoke licenses based on user roles and needs.
-   **Reporting**: Generate detailed reports on license utilization, costs, and compliance status.
-   **Integration Capabilities**: Seamlessly integrate with other enterprise systems for comprehensive asset management.

### Technology Stack

This project is built using modern, robust technologies to ensure scalability, performance, and ease of maintenance:

-   **Frontend**: React.js with TypeScript for a responsive and type-safe user interface
-   **Backend**: Node.js with Express.js for a scalable server-side architecture
-   **Database**: MySQL for flexible and efficient data storage
-   **ORM**: Sequelize for efficient data manipulation
-   **Authentication**: JWT (JSON Web Tokens) for secure user authentication
-   **API**: RESTful API design for seamless communication between frontend and backend
-   **Version Control**: Git for efficient code management and collaboration
-   **Deployment**: Dockerfile for containerization and easy deployment, multi-stage builds and single-binary approach
-   **SMTP**: Nodemailer for sending emails
-   **Chakra UI**: Instances of Chakra UI for responsive and type-safe user interface
-   **Redux**: Redux for state management
-   **Redux Toolkit**: Redux Toolkit for efficient state management
-   **React Toastify**: React Toastify for displaying toast messages
-   **Cron Job**: Node-cron for scheduling tasks

### System Architecture

The License Manager system is built with a modern, scalable architecture where components communicate in a well-defined manner:

![System Architecture](architecture.png)

### Docker Container Architecture

The application is containerized using Docker with three separate containers:

1. **Frontend Container**: Houses the React.js UI application
2. **Backend Container**: Runs the Node.js/Express server
3. **Database Container**: Hosts the MySQL database service

#### Container Networking

To enable seamless communication between these isolated containers, we implement a single user-defined Docker network. This network configuration allows containers to discover and communicate with each other using container names as hostnames.

#### Data Persistence

For the MySQL database, we mount a dedicated Docker volume to ensure data persistence. This approach provides several benefits:

-   Data remains intact even if the database container is deleted or becomes non-operational
-   Easy migration of data by mounting the volume to a new container
-   Protection against data loss during container updates or crashes

## Task 2

Refer to the dockerfiles of each service for task 2.

## Task 3

### Create a network

```bash
docker network create my-lic-network
```

### Create a volume

```bash
docker volume create licdb
```

### Run MySQL (with a name)

```bash
cd db-mysql
docker build -t lic-db-image .
docker run --name lic-db --network my-lic-network -v licdb:/var/lib/mysql -itd lic-db-image
```

### Run Backend (with a name)

```bash
cd backend
docker build -t lic-backend-image .
docker run --name lic-backend --network my-lic-network -p 5000:5000 -itd -e DB_HOST=lic-db -e DB_CHECK=root lic-backend-image
```

### Run Frontend (with a name)

```bash
cd frontend
docker build -t lic-frontend-image .
docker run -itd --name lic-frontend -p 8080:80 --network my-lic-network lic-frontend-image
```

The key advantage here is that Docker provides automatic DNS resolution for container names. Your Node.js backend can connect to MySQL using:

```javascript
const connection = mysql.createConnection({
    host: "lic-db", // Use container name as hostname
    user: "root",
    password: "your-password",
    database: "your-database",
});
```

This approach is similar to Docker Compose's service name resolution without requiring a compose file.

### Docker ps output
![Docker PS](dockerPS.png)

### Docker logs output
![Docker Logs](dockerLogs.png)

### Accessing frontend application
![Application](Applicationimage.png)

## Task 4

### Docker Hub Images

The application images are available on Docker Hub:

-   **Frontend**: `yourusername/lic-frontend:v1`
-   **Backend**: `yourusername/lic-backend:v1`
-   **Database**: `yourusername/lic-database:v1`

### Tagging Images

```bash
docker tag lic-frontend-image yourusername/lic-frontend:v1
docker tag lic-backend-image yourusername/lic-backend:v1
docker tag lic-db-image yourusername/lic-database:v1
```

### Pushing to Docker Hub

```bash
docker login
docker push yourusername/lic-frontend:v1
docker push yourusername/lic-backend:v1
docker push yourusername/lic-database:v1
```

### Docker hub link

```url
https://hub.docker.com/u/mujeeb2003

https://hub.docker.com/r/mujeeb2003/frontend
https://hub.docker.com/r/mujeeb2003/backend
https://hub.docker.com/r/mujeeb2003/mysqldb

```

## Task 5: Creative Enhancement - Health Monitoring System

### Overview

The License Manager implements a **comprehensive health monitoring system** that provides real-time visibility into all microservices. This feature showcases Docker's networking capabilities and demonstrates production-ready monitoring patterns.

### How It Works

The health monitoring system continuously checks the status of all services in the Docker network:

1. **Database Health**: Tests database connectivity and measures response times
2. **Backend Health**: Monitors service uptime, memory usage, and performance
3. **Frontend Health**: Verifies frontend service availability through HTTP requests
4. **System Overview**: Provides aggregate health scores and system status

### Implementation

The monitoring system is implemented as REST endpoints in the backend service:

#### Core Endpoints

1. **System Monitor Dashboard**: `/system-monitor`

    - Comprehensive health check of all services
    - Real-time status updates
    - Performance metrics and response times
    - Overall system health score

2. **Basic Health Check**: `/health`

    - Quick backend service health verification
    - Database connectivity test
    - Service uptime information

3. **Docker Information**: `/docker-info`
    - Container-specific information
    - Environment details
    - Logging instructions

#### Key Features

-   **Inter-Service Communication**: Uses Docker networking to communicate between containers
-   **Real-time Monitoring**: Provides live status updates with timestamps
-   **Performance Metrics**: Tracks response times and resource usage
-   **Error Detection**: Identifies and reports service failures
-   **Production Ready**: Implements industry-standard health check patterns

### Usage

#### Access the monitoring dashboard:

```bash
# Comprehensive system health
curl http://localhost:5000/system-monitor

# Basic health check
curl http://localhost:5000/health

# Docker container information
curl http://localhost:5000/docker-info
```

### Sample Output

```json
{
    "system": "License Manager Microservices",
    "timestamp": "2025-06-06T05:45:32.123Z",
    "services": {
        "database": {
            "status": "healthy",
            "response_time": "45ms",
            "host": "lic-db",
            "type": "MySQL"
        },
        "backend": {
            "status": "running",
            "uptime": "127s",
            "memory_usage": "34MB",
            "node_version": "v20.x.x"
        },
        "frontend": {
            "status": "healthy",
            "response_time": "23ms",
            "status_code": 200,
            "type": "React SPA"
        }
    },
    "overall_status": "ALL_SYSTEMS_OPERATIONAL",
    "health_score": "100%",
    "summary": {
        "healthy_services": 3,
        "total_services": 3,
        "issues": 0
    }
}

```
## Project Conclusion

The License Manager project demonstrates the power of containerized microservices architecture, providing seamless integration between isolated components while maintaining robust data persistence and monitoring capabilities.

*Thank you for exploring the License Manager project!*

# ~ Mujeeb Ur Rehman 2112345