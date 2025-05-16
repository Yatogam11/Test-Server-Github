// server.js
require('dotenv').config();
const express = require('express');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware dasar
app.use(express.json());

// Route sederhana
app.get('/', (req, res) => {
  res.send(`
    <h1>Selamat Datang di Server Dasar!</h1>
    <p>Server berjalan dengan baik di port ${PORT}</p>
    <h2>Environment Variables:</h2>
    <pre>${JSON.stringify(process.env, null, 2)}</pre>
  `);
});

// Route untuk health check
app.get('/health', (req, res) => {
  res.json({ status: 'healthy', timestamp: new Date() });
});

// Jalankan server
app.listen(PORT, () => {
  console.log(`Server berjalan di http://localhost:${PORT}`);
  console.log(`Mode: ${process.env.NODE_ENV || 'development'}`);
});
