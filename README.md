# Zewg (ዘውግ) – Student Opportunities Hub

A Flutter application for connecting students with opportunities including internships, jobs, and scholarships.

Zewg (ዘውግ) in Amharic means "connection based on category." The app connects students with relevant opportunities by organizing them into categories, making it easier to discover, track, and manage.

## Features

- **Onboarding Flow**: Welcome screens for new users
- **Authentication**: Login and signup functionality
- **Opportunities Discovery**: Browse and search for internships, jobs, and scholarships
- **Curator Dashboard**: Manage and publish opportunities
- **Profile Management**: User profile and saved opportunities
- **Responsive Design**: Works on mobile, web, and desktop
- **Role-based Access**: Support for students and curators
- **CRUD Operations**: Full create, read, update, delete for opportunities

## Structure

- **Zewg_user/** — student-facing app (browse, save, apply)
- **zewg_admin/** — curator dashboard (CRUD opportunities)
- **backend/** — Express + SQLite + JWT API

## Quick start

### 1. Backend

```bash
cd backend
npm install
npm start
```

API: http://localhost:3000

### 2. User app

```bash
cd Zewg_user
flutter pub get
flutter run

# Android emulator:
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000
```

Demo login: `alex@zewg.com` / `password123`

### 3. Admin app

```bash
cd zewg_admin
flutter pub get
flutter run
```

Demo login: `curator@zewg.com` / `curator123`

## Architecture

- Clean architecture per feature: data → domain → presentation
- Riverpod 3 (Notifier, AsyncNotifier) for state
- SQLite cache-first repositories (local → network → save)
- JWT auth with role-based routes on the API

## API endpoints

| Method | Path |
|--------|------|
| POST | /auth/register |
| POST | /auth/login |
| GET | /opportunities |
| POST | /opportunities (curator) |
| PUT | /opportunities/:id (curator) |
| DELETE | /opportunities/:id (curator) |

## Getting Started

### Prerequisites

- Flutter SDK (3.11.4 or higher)
- Dart SDK
- Chrome (for web development)
- Node.js (for backend)

### Installation

1. Clone the repository:

```bash
git clone https://github.com/Belaw19/Zewg.git
cd Zewg
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
# For Chrome
flutter run -d chrome

# For mobile
flutter run

# For Windows
flutter run -d windows
```

## Project Structure

```
lib/
├── main.dart              # Application entry point
├── core/                  # Core functionality
│   ├── routing/          # Navigation and routing
│   ├── theme/            # App theming and styles
│   ├── widgets/          # Reusable widgets
│   ├── utils/            # Utility functions
│   └── constants/        # App constants
└── features/             # Feature modules
    ├── onboarding/       # Onboarding screens
    ├── auth/             # Authentication
    ├── home/             # Home and discovery
    ├── opportunities/    # Opportunity details
    ├── profile/          # User profile
    └── curator/          # Curator dashboard
```

## Tech Stack

- **Flutter** – UI framework
- **Dart** – Programming language
- **Material 3** – Design system
- **go_router** – Navigation and routing
- **google_fonts** – Custom fonts
- **intl** – Internationalization and date formatting
- **Express.js** – Backend API framework
- **SQLite** – Local database
- **JWT** – Authentication

## Team Members

| Full Name        | ID (UGR/XXXX/YY) |
| ---------------- | ---------------- |
| Beimnet Abdi     | UGR/8524/16      |
| Kebron Gizachew  | UGR/2666/16      |
| Kidus Girma      | UGR/7576/16      |
| Tsedeniya Fiseha | UGR/9263/16      |
| Zenebu Melaku    | UGR/6058/16      |

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
