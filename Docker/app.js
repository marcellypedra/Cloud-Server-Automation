// Import the Express library
const express = require('express');

// Create an Express application
const app = express();

// Define a port number
const PORT = 3000;

// Define a basic route (homepage)
app.get('/', (req, res) => {
  res.send('Hello, World!');
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});

