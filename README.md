# Location Tracking App

A Flutter application for tracking location, managing geofences, and providing time summaries for predefined locations.

## Features

- Real-time location tracking in the background
- Geofence management with visual map interface
- Time tracking for each geofence location
- Daily summaries of time spent in different locations
- Persistent storage using Hive
- Firebase integration for authentication and data storage

## Getting Started

### Prerequisites

- Flutter SDK (>=3.2.0)
- Dart SDK (>=3.2.0)
- Android Studio / VS Code
- Firebase project setup

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/location-tracking-app.git
cd location-tracking-app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
   - Create a new Firebase project
   - Add Android/iOS apps in Firebase console
   - Download and add the configuration files:
     - Android: `google-services.json` to `android/app/`
     - iOS: `GoogleService-Info.plist` to `ios/Runner/`

4. Create a `config.env` file in the root directory with your Firebase configuration:
```
FIREBASE_API_KEY=your_api_key
FIREBASE_APP_ID=your_app_id
FIREBASE_MESSAGING_SENDER_ID=your_sender_id
FIREBASE_PROJECT_ID=your_project_id
```

5. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── models/           # Data models
├── providers/        # State management
├── screens/          # UI screens
├── util/            # Utility functions
└── main.dart        # App entry point
```

## Dependencies

- `background_location`: Background location tracking
- `google_maps_flutter`: Map visualization
- `hive`: Local storage
- `provider`: State management
- `firebase_core`: Firebase integration
- `firebase_auth`: Authentication
- `cloud_firestore`: Cloud database

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- All contributors who have helped with the project
