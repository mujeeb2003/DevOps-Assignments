const express = require("express");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const cors = require("cors");
require("dotenv").config();
const licenseRouter = require("./routes/licenseRouter.js");
const userRouter = require("./routes/userRouter.js");
const router = require("./routes/Router.js");
const app = express();
const { encryptEnvPassword } = require("./utils/encryptPassword.js");

const allowedOrigins = [
    "https://license-manager-cyan.vercel.app",
    "http://localhost:8080",
];

// encryptEnvPassword("DB_CHECK");
encryptEnvPassword("SMTP_PASS");

require("./cron/licenseCron");
const PORT = process.env.PORT || 5000;
// const { running } = require("./licenseChecker-obfuscated.js");

const { db } = require("./config/databaseConfig.js");

app.use(
    cors({
        origin: allowedOrigins[1],
        credentials: true,
        methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
        allowedHeaders: ["Content-Type", "Authorization"],
    })
);
app.use(cookieParser());
app.use(express.json());
app.use(bodyParser.json());

// app.use(running);
app.use("/", router);
app.use("/license", licenseRouter);
app.use("/user", userRouter);


// Basic health check
app.get("/health", async (req, res) => {
    try {
        await db.authenticate();
        res.status(200).json({
            status: "healthy",
            service: "backend",
            timestamp: new Date().toISOString(),
            uptime: `${Math.floor(process.uptime())}s`,
        });
    } catch (error) {
        res.status(503).json({
            status: "unhealthy",
            service: "backend",
            error: error.message,
            timestamp: new Date().toISOString(),
        });
    }
});

// Comprehensive system monitor (Main Creative Feature)
app.get("/system-monitor", async (req, res) => {
    const health = {
        system: "License Manager Microservices",
        timestamp: new Date().toISOString(),
        monitoring_version: "1.0.0",
        services: {},
    };

    // Check Database Service
    try {
        const dbStart = Date.now();
        await db.authenticate();
        health.services.database = {
            status: "healthy",
            response_time: `${Date.now() - dbStart}ms`,
            host: process.env.DB_HOST || "lic-db-primary",
            type: "MySQL",
            last_check: new Date().toISOString(),
        };
    } catch (error) {
        health.services.database = {
            status: "unhealthy",
            error: error.message,
            host: process.env.DB_HOST || "lic-db-primary",
            last_check: new Date().toISOString(),
        };
    }

    // Backend Service Status
    health.services.backend = {
        status: "running",
        uptime: `${Math.floor(process.uptime())}s`,
        memory_usage: `${Math.round(
            process.memoryUsage().heapUsed / 1024 / 1024
        )}MB`,
        node_version: process.version,
        container: process.env.HOSTNAME || "unknown",
        last_check: new Date().toISOString(),
    };

    // Frontend Service Check (HTTP request to frontend container)
    try {
        const http = require("http");
        const frontendStart = Date.now();

        await new Promise((resolve, reject) => {
            const options = {
                hostname: "lic-frontend",
                port: 80,
                path: "/",
                method: "GET",
                timeout: 3000,
            };

            const req = http.request(options, (res) => {
                health.services.frontend = {
                    status: "healthy",
                    response_time: `${Date.now() - frontendStart}ms`,
                    status_code: res.statusCode,
                    type: "React SPA",
                    last_check: new Date().toISOString(),
                };
                resolve();
            });

            req.on("error", (error) => {
                health.services.frontend = {
                    status: "unhealthy",
                    error: error.message,
                    last_check: new Date().toISOString(),
                };
                resolve(); // Don't reject, just mark as unhealthy
            });

            req.on("timeout", () => {
                health.services.frontend = {
                    status: "timeout",
                    error: "Request timeout after 3s",
                    last_check: new Date().toISOString(),
                };
                req.destroy();
                resolve();
            });

            req.setTimeout(3000);
            req.end();
        });
    } catch (error) {
        health.services.frontend = {
            status: "unreachable",
            error: error.message,
            last_check: new Date().toISOString(),
        };
    }

    // Calculate Overall System Status
    const serviceStatuses = Object.values(health.services).map((s) => s.status);
    const healthyCount = serviceStatuses.filter(
        (s) => s === "healthy" || s === "running"
    ).length;
    const totalServices = serviceStatuses.length;

    if (healthyCount === totalServices) {
        health.overall_status = "ALL_SYSTEMS_OPERATIONAL";
        health.health_score = "100%";
    } else if (healthyCount > 0) {
        health.overall_status = "PARTIAL_OUTAGE";
        health.health_score = `${Math.round(
            (healthyCount / totalServices) * 100
        )}%`;
    } else {
        health.overall_status = "SYSTEM_DOWN";
        health.health_score = "0%";
    }

    // Add system summary
    health.summary = {
        healthy_services: healthyCount,
        total_services: totalServices,
        issues: serviceStatuses.filter(
            (s) => s !== "healthy" && s !== "running"
        ).length,
    };

    res.json(health);
});

// Docker container logs info
app.get("/docker-info", (req, res) => {
    res.json({
        message: "Docker Container Information",
        container: {
            hostname: process.env.HOSTNAME || "unknown",
            platform: process.platform,
            architecture: process.arch,
        },
        environment: {
            node_env: process.env.NODE_ENV || "development",
            db_host: process.env.DB_HOST || "not_set",
        },
        logs_command: "Use: docker logs lic-backend --tail 50",
        monitoring_endpoints: {
            health: "/health",
            system_monitor: "/system-monitor",
            docker_info: "/docker-info",
        },
    });
});

app.listen(PORT, async () => {
    console.log(`Server started on http://localhost:${PORT}`);
});
