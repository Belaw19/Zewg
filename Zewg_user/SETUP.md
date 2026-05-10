# Setup Instructions

If you're getting import errors after pulling the latest changes, follow these steps:

## Step 1: Pull Latest Changes
```bash
git pull origin main
```

## Step 2: Install Dependencies
```bash
flutter pub get
```

## Step 3: Clean Build (if still having issues)
```bash
flutter clean
flutter pub get
```

## Step 4: Run the App
```bash
# For Chrome (Web)
flutter run -d chrome

# For Windows
flutter run -d windows

# For Mobile
flutter run
```

## Common Issues

### Import Errors
If you see "Target of URI doesn't exist" errors:
1. Make sure you've run `flutter pub get`
2. Try restarting your IDE/editor
3. Run `flutter clean` then `flutter pub get`

### SDK Version Issues
Make sure you have Flutter SDK 3.11.4 or higher:
```bash
flutter --version
```

If your version is lower, update Flutter:
```bash
flutter upgrade
```

### Missing Assets
If images don't load:
1. Make sure you've pulled the latest changes
2. Restart the app (hot reload won't work for asset changes)

## Project Structure
```
lib/
├── main.dart              # App entry point
├── core/                  # Core functionality
│   ├── routing/          # Navigation
│   ├── theme/            # Theming
│   ├── widgets/          # Reusable widgets
│   └── constants/        # Constants
└── features/             # Feature modules
    ├── auth/             # Authentication
    ├── home/             # Home & opportunities
    └── profile/          # User profile
```

## Need Help?
If you're still having issues, try:
1. Delete the `pubspec.lock` file
2. Run `flutter pub get` again
3. Restart your IDE
