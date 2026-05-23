const express = require('express');
const bcrypt = require('bcryptjs');
const { randomUUID } = require('crypto');
const db = require('../db');
const { signToken } = require('../middleware/auth');

const router = express.Router();

function toPublicUser(row) {
  return {
    id: row.id,
    name: row.name,
    email: row.email,
    role: row.role,
    createdAt: row.created_at,
  };
}

router.post('/register', (req, res) => {
  const { name, email, password, role = 'student' } = req.body ?? {};
  if (!name?.trim() || !email?.trim() || !password) {
    return res.status(400).json({ message: 'name, email, and password are required' });
  }
  const normalizedRole = role === 'curator' ? 'curator' : 'student';
  const normalizedEmail = email.trim().toLowerCase();

  const exists = db.prepare('SELECT id FROM users WHERE email = ?').get(normalizedEmail);
  if (exists) return res.status(409).json({ message: 'An account with this email already exists' });

  const id = randomUUID();
  const passwordHash = bcrypt.hashSync(password, 10);
  db.prepare(
    'INSERT INTO users (id, name, email, password_hash, role) VALUES (?, ?, ?, ?, ?)',
  ).run(id, name.trim(), normalizedEmail, passwordHash, normalizedRole);

  const user = db.prepare('SELECT * FROM users WHERE id = ?').get(id);
  const token = signToken(user);
  return res.status(201).json({ token, user: toPublicUser(user) });
});

router.post('/login', (req, res) => {
  const { email, password } = req.body ?? {};
  if (!email?.trim() || !password) {
    return res.status(400).json({ message: 'email and password are required' });
  }

  const user = db
    .prepare('SELECT * FROM users WHERE email = ?')
    .get(email.trim().toLowerCase());
  if (!user || !bcrypt.compareSync(password, user.password_hash)) {
    return res.status(401).json({ message: 'Invalid email or password' });
  }

  const token = signToken(user);
  return res.json({ token, user: toPublicUser(user) });
});

module.exports = router;
