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

## Getting Started

### Prerequisites

- Flutter SDK (3.11.4 or higher)
- Dart SDK
- Chrome (for web development)

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

## Team Members

| Full Name | ID (UGR/XXXX/YY) |
| --------- | ---------------- |
| Beimnet Abdi  | UGR/8524/16      |
| Kebron Gizachew  | UGR/2666/16      |
| Kidus Girma  | UGR/7576/16     |
| Tsedeniya Fiseha| UGR/9263/16      |
| Zenebu Melaku  | UGR/6058/16      |

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.
