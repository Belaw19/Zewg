const express = require('express');
const { randomUUID } = require('crypto');
const db = require('../db');
const { authMiddleware, requireRole } = require('../middleware/auth');

const router = express.Router();

function parseJsonArray(value) {
  if (Array.isArray(value)) return value;
  if (typeof value === 'string' && value.trim()) {
    try {
      return JSON.parse(value);
    } catch {
      return [];
    }
  }
  return [];
}

function serializeJsonArray(value) {
  return JSON.stringify(parseJsonArray(value));
}

function mapRow(row) {
  return {
    id: row.id,
    title: row.title,
    description: row.description,
    category: row.category,
    company: row.company,
    deadline: row.deadline,
    location: row.location,
    type: row.type,
    link: row.link,
    createdBy: row.created_by,
    createdAt: row.created_at,
    workType: row.work_type || 'Remote',
    compensation: row.compensation_type || 'Paid',
    compensationAmount: row.compensation_amount || '',
    education: row.education || '',
    experience: row.experience || '',
    skills: parseJsonArray(row.skills),
    applicationSteps: parseJsonArray(row.application_steps),
    coverImagePath: row.cover_image_path || '',
  };
}

function categoryFromType(type) {
  switch (type) {
    case 'job':
      return 'JOB';
    case 'scholarship':
      return 'SCHOLARSHIP';
    default:
      return 'INTERNSHIP';
  }
}

function typeFromCategory(category) {
  const c = String(category || '').toUpperCase();
  if (c === 'JOB' || c === 'JOBS') return 'job';
  if (c === 'SCHOLARSHIP' || c === 'SCHOLARSHIPS') return 'scholarship';
  return 'internship';
}

function readBodyFields(body, existing = {}) {
  const resolvedType = body.type || typeFromCategory(body.category) || existing.type || 'internship';
  const resolvedCategory = body.category || categoryFromType(resolvedType) || existing.category || 'INTERNSHIP';

  return {
    title: (body.title ?? existing.title ?? '').trim(),
    description: (body.description ?? existing.description ?? '').trim(),
    category: resolvedCategory,
    company: (body.company ?? existing.company ?? '').trim(),
    deadline: body.deadline ?? existing.deadline ?? '',
    location: body.location ?? existing.location ?? '',
    type: resolvedType,
    link: body.link ?? existing.link ?? '',
    workType: body.workType ?? existing.work_type ?? 'Remote',
    compensation: body.compensation ?? existing.compensation_type ?? 'Paid',
    compensationAmount: body.compensationAmount ?? existing.compensation_amount ?? '',
    education: body.education ?? existing.education ?? '',
    experience: body.experience ?? existing.experience ?? '',
    skills: serializeJsonArray(body.skills ?? existing.skills ?? '[]'),
    applicationSteps: serializeJsonArray(
      body.applicationSteps ?? existing.application_steps ?? '[]',
    ),
    coverImagePath: body.coverImagePath ?? existing.cover_image_path ?? '',
  };
}

router.get('/', (_req, res) => {
  const rows = db.prepare('SELECT * FROM opportunities ORDER BY created_at DESC').all();
  res.json(rows.map(mapRow));
});

router.post('/', authMiddleware, requireRole('curator'), (req, res) => {
  const fields = readBodyFields(req.body ?? {});

  if (!fields.title || !fields.description || !fields.company) {
    return res.status(400).json({ message: 'title, description, and company are required' });
  }

  const id = randomUUID();

  db.prepare(`
    INSERT INTO opportunities (
      id, title, description, category, company, deadline, location, type, link, created_by,
      work_type, compensation_type, compensation_amount, education, experience,
      skills, application_steps, cover_image_path
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `).run(
    id,
    fields.title,
    fields.description,
    fields.category,
    fields.company,
    fields.deadline,
    fields.location,
    fields.type,
    fields.link,
    req.user.sub,
    fields.workType,
    fields.compensation,
    fields.compensationAmount,
    fields.education,
    fields.experience,
    fields.skills,
    fields.applicationSteps,
    fields.coverImagePath,
  );

  const row = db.prepare('SELECT * FROM opportunities WHERE id = ?').get(id);
  return res.status(201).json(mapRow(row));
});

router.put('/:id', authMiddleware, requireRole('curator'), (req, res) => {
  const existing = db.prepare('SELECT * FROM opportunities WHERE id = ?').get(req.params.id);
  if (!existing) return res.status(404).json({ message: 'Opportunity not found' });

  const fields = readBodyFields(req.body ?? {}, existing);

  db.prepare(`
    UPDATE opportunities SET
      title = ?, description = ?, category = ?, company = ?,
      deadline = ?, location = ?, type = ?, link = ?,
      work_type = ?, compensation_type = ?, compensation_amount = ?,
      education = ?, experience = ?, skills = ?, application_steps = ?, cover_image_path = ?
    WHERE id = ?
  `).run(
    fields.title,
    fields.description,
    fields.category,
    fields.company,
    fields.deadline,
    fields.location,
    fields.type,
    fields.link,
    fields.workType,
    fields.compensation,
    fields.compensationAmount,
    fields.education,
    fields.experience,
    fields.skills,
    fields.applicationSteps,
    fields.coverImagePath,
    req.params.id,
  );

  const row = db.prepare('SELECT * FROM opportunities WHERE id = ?').get(req.params.id);
  return res.json(mapRow(row));
});

router.delete('/:id', authMiddleware, requireRole('curator'), (req, res) => {
  const result = db.prepare('DELETE FROM opportunities WHERE id = ?').run(req.params.id);
  if (result.changes === 0) return res.status(404).json({ message: 'Opportunity not found' });
  return res.status(204).send();
});

module.exports = router;
