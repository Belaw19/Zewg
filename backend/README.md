# Zewg API (local)

## Setup

```bash
cd backend
npm install
npm start
```

Server: `http://localhost:3000`

## Seeded accounts

| Email | Password | Role |
|-------|----------|------|
| alex@zewg.com | password123 | student |
| curator@zewg.com | curator123 | curator |

## Endpoints

- `POST /auth/register`
- `POST /auth/login`
- `GET /opportunities`
- `POST /opportunities` (curator + Bearer token)
- `PUT /opportunities/:id` (curator)
- `DELETE /opportunities/:id` (curator)

## Flutter base URL

- Windows / iOS simulator: `http://localhost:3000`
- Android emulator: `http://10.0.2.2:3000`
- Physical device: your machine LAN IP, e.g. `http://192.168.1.10:3000`

Set via `--dart-define=API_BASE_URL=http://10.0.2.2:3000` when running Flutter.
