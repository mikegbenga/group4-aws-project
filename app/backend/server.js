const express = require("express");
const { Pool } = require("pg");

const app = express();

app.use(express.json());

const pool = new Pool({
    host: process.env.DB_HOST,
    port: 5432,
    database: process.env.DB_NAME,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    ssl: {
        rejectUnauthorized: false
    }
});

app.get("/api/health", async (req, res) => {

    try {

        const result = await pool.query("SELECT NOW()");

        res.json({
            status: "healthy",
            application: "Group 4 Backend",
            database: "connected",
            server_time: result.rows[0].now
        });

    } catch (error) {

        console.error("Database error:", error);

        res.status(500).json({
            status: "unhealthy",
            application: "Group 4 Backend",
            database: "disconnected",
            error: error.message
        });

    }

});


app.get("/api/message", (req, res) => {

    res.json({
        message: "Group 4 AWS Docker Compose application is working."
    });

});


const PORT = 3000;

app.listen(PORT, "0.0.0.0", () => {

    console.log(`Backend running on port ${PORT}`);

});
