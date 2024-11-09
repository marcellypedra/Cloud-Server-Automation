// Import the Express library
const express = require('express');

// Create an Express application
const app = express();

// Define a port number
const PORT = 3000;

// Define a basic route (homepage)
app.get('/', (req, res) => {
  res.send('Dockerizing Node Application');
});

// Start the server
app.listen(PORT, '0.0.0.0', function() {
    console.log(`The server is running on http://0.0.0.0:${PORT}`);
});

