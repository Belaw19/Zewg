const Database = require('better-sqlite3');
const path = require('path');
const bcrypt = require('bcryptjs');

const dbPath = path.join(__dirname, '..', 'zewg.db');
const db = new Database(dbPath);

db.exec(`
  CREATE TABLE IF NOT EXISTS users (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    role TEXT NOT NULL CHECK(role IN ('student', 'curator')),
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
  );

  CREATE TABLE IF NOT EXISTS opportunities (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    category TEXT NOT NULL,
    company TEXT NOT NULL,
    deadline TEXT NOT NULL,
    location TEXT NOT NULL,
    type TEXT NOT NULL CHECK(type IN ('job', 'internship', 'scholarship')),
    link TEXT NOT NULL DEFAULT '',
    created_by TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    work_type TEXT NOT NULL DEFAULT 'Remote',
    compensation_type TEXT NOT NULL DEFAULT 'Paid',
    compensation_amount TEXT NOT NULL DEFAULT '',
    education TEXT NOT NULL DEFAULT '',
    experience TEXT NOT NULL DEFAULT '',
    skills TEXT NOT NULL DEFAULT '[]',
    application_steps TEXT NOT NULL DEFAULT '[]',
    cover_image_path TEXT NOT NULL DEFAULT ''
  );
`);

function migrateOpportunitiesColumns() {
  const cols = db.prepare('PRAGMA table_info(opportunities)').all().map((c) => c.name);
  const add = (name, sql) => {
    if (!cols.includes(name)) db.exec(`ALTER TABLE opportunities ADD COLUMN ${sql}`);
  };
  add('work_type', 'work_type TEXT NOT NULL DEFAULT \'Remote\'');
  add('compensation_type', 'compensation_type TEXT NOT NULL DEFAULT \'Paid\'');
  add('compensation_amount', 'compensation_amount TEXT NOT NULL DEFAULT \'\'');
  add('education', 'education TEXT NOT NULL DEFAULT \'\'');
  add('experience', 'experience TEXT NOT NULL DEFAULT \'\'');
  add('skills', 'skills TEXT NOT NULL DEFAULT \'[]\'');
  add('application_steps', 'application_steps TEXT NOT NULL DEFAULT \'[]\'');
  add('cover_image_path', 'cover_image_path TEXT NOT NULL DEFAULT \'\'');
}

migrateOpportunitiesColumns();

function seedIfEmpty() {
  const userCount = db.prepare('SELECT COUNT(*) AS c FROM users').get().c;
  if (userCount > 0) return;

  const curatorHash = bcrypt.hashSync('curator123', 10);
  const studentHash = bcrypt.hashSync('password123', 10);

  const insertUser = db.prepare(
    'INSERT INTO users (id, name, email, password_hash, role) VALUES (?, ?, ?, ?, ?)',
  );

  insertUser.run('u1', 'Alex Morgan', 'alex@zewg.com', studentHash, 'student');
  insertUser.run('u2', 'Curator One', 'curator@zewg.com', curatorHash, 'curator');

  const insertOpp = db.prepare(`
    INSERT INTO opportunities
      (id, title, description, category, company, deadline, location, type, link, created_by)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `);

  const seeds = [
    ['1', 'UX Intern', 'Join Google UX team as an intern.', 'INTERNSHIP', 'Google', 'Oct 30', 'New York', 'internship', 'https://careers.google.com', 'u2'],
    ['2', 'Social Media Intern', 'Support UNICEF communications.', 'INTERNSHIP', 'UNICEF', 'Nov 15', 'Addis Ababa, Ethiopia', 'internship', 'https://www.unicef.org/careers', 'u2'],
    ['3', 'Public Health Scholarship', 'WHO Public Health Scholarship.', 'SCHOLARSHIP', 'World Health Organization', 'Nov 15', 'Global', 'scholarship', 'https://www.who.int/scholarships', 'u2'],
    ['4', 'Product Designer (New Grad)', 'Figma new-grad product designer.', 'JOB', 'Figma', 'Oct 25', 'San Francisco, CA', 'job', 'https://www.figma.com/careers', 'u2'],
    ['5', 'Frontend Developer (Entry Level)', 'Build web apps at Google.', 'JOB', 'Google', 'Nov 10', 'New York, NY', 'job', 'https://careers.google.com', 'u2'],
  ];

  for (const row of seeds) insertOpp.run(...row);
}

seedIfEmpty();

module.exports = db;
