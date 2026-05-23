const express = require('express');
const cors = require('cors');
const authRoutes = require('./routes/auth');
const opportunityRoutes = require('./routes/opportunities');

require('./db');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.get('/health', (_req, res) => res.json({ status: 'ok' }));

app.use('/auth', authRoutes);
app.use('/opportunities', opportunityRoutes);

app.use((err, _req, res, _next) => {
  console.error(err);
  res.status(500).json({ message: 'Internal server error' });
});

app.listen(PORT, () => {
  console.log(`Zewg API running at http://localhost:${PORT}`);
});
