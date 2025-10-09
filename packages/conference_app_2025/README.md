# Conference App 2025

A Flutter conference application demonstrating modern architecture patterns and clean code practices.

## Architecture

The app follows a layered architecture with clear separation of concerns:

### Core Patterns
- **Command-Resource Pattern**: State management using Provider + ChangeNotifier
- **Extension Types**: Immutable data models with type-safe JSON handling
- **Dependency Injection**: Service location with `get_it` + Provider

### Directory Structure

```
lib/
  ├── core/                # Shared utilities and abstractions
  ├── data_models/         # Extension type models
  ├── data_api/            # Data access layer
  ├── data_resources/      # UI state holders (Resources)
  ├── data_commands/       # Business logic (Commands)
  ├── di/                  # Dependency injection setup
  ├── ui_*/                # Feature-specific screens
  ├── ui_kit/              # Reusable UI components
  └── main.dart
```

Read more about the architecture in article: https://medium.com/@antmalofeev/flutter-app-ai-centric-architecture-for-small-startups-intro-notes-99a028adc9e5

### Key Layers
- **Data Layer**: Models (`data_models/`) and APIs (`data_api/`)
- **State Layer**: Resources (`data_resources/`)
- **Data Logic Layer**: Commands (`data_commands/`)
- **UI Layer**: Domain-specific screens (`ui_conferences/`, `ui_schedule/`, `ui_profile/`)
- **Core**: Shared utilities and services

## Prerequisites

- Flutter SDK 3.32+
- Dart SDK 3.9+

## Getting Started

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Run the App

```bash
flutter run
```

For specific platforms:

```bash
flutter run -d ios          # iOS
flutter run -d android      # Android
flutter run -d macos        # macOS
```

### Testing Deep Links (iOS only)

On iOS Simulator:

```bash
xcrun simctl openurl booted "myapp://conference/1"
```

## Testing

### Run All Tests

```bash
flutter test
```

### Golden Tests

Run golden tests:

```bash
flutter test test/golden/
```

Update golden images after UI changes:

```bash
flutter test --update-goldens
```

Golden test configuration is defined in `test/flutter_test_config.dart` using `golden_toolkit`.

### Test Structure

```
test/
  ├── golden/              # UI golden tests
  │   ├── goldens/         # Golden image references
  │   └── failures/        # Failed test comparisons
  ├── flutter_test_config.dart
  └── test_helpers.dart
```

## Additional Resources

- See `.cursor/rules/` for detailed architectural patterns
- `IOS_FEATURES.md` for iOS-specific features and notifications
