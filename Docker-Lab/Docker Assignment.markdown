# Docker Assignment: Build and Deploy a Microservices Application

## Objective
This assignment challenges you to apply Docker concepts creatively by designing and deploying a microservices-based application using manual Docker commands. You will combine multiple services, leverage Docker networking, volumes, and custom images, and think critically to solve real-world problems. The goal is to foster innovation and problem-solving beyond in-class exercises.

## Prerequisites
- Docker Desktop installed on your machine.
- A Docker Hub account (free tier is sufficient).
- Basic familiarity with Git, command-line interfaces, and at least one programming language (e.g., Node.js, Python, or Go).
- Access to the lecture slides ("Docker Advance.pptx") for reference.

## Assignment Overview
You will create a microservices application with at least **two services** (e.g., a web app and a database, or an API and a worker service). The application should demonstrate Docker’s power in simplifying development, deployment, and scalability. You are free to choose the application’s purpose, but it must involve creativity and critical thinking.

### Example Ideas (Choose One or Create Your Own)
1. **Task Manager**: A web app (Node.js/Flask) for creating tasks, with a MongoDB/PostgreSQL backend for storing tasks.
2. **Weather Dashboard**: A Python API that fetches real-time weather data (using a public API like OpenWeatherMap) and a frontend (HTML/CSS/JS or React) to display it, with Redis caching responses.
3. **Chat Application**: A simple real-time chat server (Node.js with Socket.IO) and a PostgreSQL database to store messages.
4. **Your Idea**: Propose a unique application (e.g., a voting system, a recipe generator, or a fitness tracker) that uses at least two services.

## Assignment Tasks

### Task 1: Design Your Application
1. Define the purpose and functionality of your application in a `README.md`. Include:
   - A description of the application and its use case.
   - A diagram or explanation of the microservices architecture (e.g., which services interact and how).
   - The tech stack for each service (e.g., Node.js, Python, MongoDB, Redis).
2. Identify at least two services (e.g., a frontend and a backend, or an API and a database).
3. Specify how Docker will be used (e.g., containers, networking, volumes).

### Task 2: Implement the Services
1. Create a Git repository for your project.
2. Develop the code for each service. You can:
   - Write your own code from scratch.
   - Use open-source templates or tutorials as a starting point (cite sources in `README.md`).
3. Ensure each service is containerized with its own `Dockerfile`. Use multi-stage builds where applicable to optimize image size.
   - Example: For a Node.js service, use `node:18` for building and `node:18-slim` for runtime.
   - Include a `HEALTHCHECK` instruction in at least one Dockerfile to monitor service health.
4. Test each service locally (outside Docker) to ensure functionality.

### Task 3: Containerize and Run
1. Create a custom Docker network for your services:
   ```
   docker network create app-network
   ```
2. Build Docker images for each service. For example, if you have a web service and a database:
   ```
   docker build -t web-service ./web
   docker build -t db-service ./db
   ```
3. Run the services as containers on the custom network, ensuring they communicate. For example:
   - Database (e.g., PostgreSQL):
     ```
     docker volume create db-data
     docker run -d --name db-container --network app-network -v db-data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=secret postgres
     ```
   - Web service (e.g., Node.js app connecting to the database):
     ```
     docker run -d --name web-container --network app-network -p 3000:3000 web-service
     ```
4. Verify the application works by interacting with it (e.g., via a browser, curl, or a client tool). For example, access `http://localhost:3000` for a web app.
5. Check container logs to debug any issues:
   ```
   docker logs web-container
   ```

### Task 4: Deployment to Docker Hub
1. Tag your images for your Docker Hub repository:
   ```
   docker tag web-service yourdockerhubusername/web-service:v1
   docker tag db-service yourdockerhubusername/db-service:v1
   ```
   Replace `yourdockerhubusername` with your actual Docker Hub username.
2. Log in to Docker Hub:
   ```
   docker login
   ```
3. Push the images to Docker Hub:
   ```
   docker push yourdockerhubusername/web-service:v1
   docker push yourdockerhubusername/db-service:v1
   ```
4. Verify the images are available on Docker Hub by visiting your repository page.

### Task 5: Creative Enhancement
Add **one creative feature** to your application that showcases Docker’s capabilities or solves a unique problem. Examples:
- Implement a custom logging mechanism and use `docker logs` to analyze service behavior.
- Add a monitoring script in one service that checks the health of another service (e.g., pinging the database) and restarts it if unhealthy using `docker restart`.
- Simulate load balancing by running multiple instances of a service manually:
  ```
  docker run -d --name web-container-2 --network app-network -p 3001:3000 web-service
  ```
- Use a volume to share data between services (e.g., a shared configuration file).
Document this feature in your `README.md`, explaining its purpose and how it was implemented.

### Task 6: Reflection (Written Component)
Write a reflection (200-250 words) in a file called `reflection.txt`, answering:
- What inspired your application idea, and how did you incorporate creativity?
- What challenges did you face in designing or implementing the microservices architecture without Docker Compose, and how did you address them?
- How did Docker’s features (e.g., networking, volumes, multi-stage builds) make your development process easier or more robust?
- How could your application be extended or improved in a production environment?

## Submission Instructions
1. Create a public GitHub repository for your project.
2. Include the following in your repository:
   - Source code for all services.
   - `Dockerfile` for each service.
   - `README.md` with:
     - Application description, architecture diagram, and setup instructions (including all `docker` commands to run the app).
     - Screenshots or logs showing the application running.
     - A link to your Docker Hub repository with the pushed images.
     - Explanation of the creative enhancement.
   - `reflection.txt` with your written reflection.
3. Submit the GitHub repository URL to the course instructor by the deadline.

## Deadline
Submit before the last class of the semester.