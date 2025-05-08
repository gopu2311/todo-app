const express = require('express');
const path = require('path');
const app = express();
const PORT = 3000;

// In-memory todo list (resets on restart)
let todos = [];

// Middleware
app.use(express.json()); // for parsing application/json
app.use(express.static(path.join(__dirname, 'public'))); // serve static frontend

// API: Get all todos
app.get('/api/todos', (req, res) => {
  res.json(todos);
});

// API: Add a new todo
app.post('/api/todos', (req, res) => {
  const { text } = req.body;
  if (!text || typeof text !== 'string') {
    return res.status(400).json({ error: 'Invalid task' });
  }
  const newTodo = {
    id: Date.now(),
    text: text.trim()
  };
  todos.push(newTodo);
  res.status(201).json(newTodo);
});

// API: Delete a todo by ID
app.delete('/api/todos/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const index = todos.findIndex(todo => todo.id === id);
  if (index === -1) {
    return res.status(404).json({ error: 'Task not found' });
  }
  todos.splice(index, 1);
  res.status(204).send();
});

// Start the server
app.listen(PORT, () => {
  console.log(`✅ Server is running on http://localhost:${PORT}`);
});
