
# 🎬 Movies App

<p align="center">
  <img src="assets/images/movie_app_croped.jpg" alt="Movies App icon" width="120" />
</p>

<p align="center">
  <strong>Discover movies, explore their details, and save what you want to watch next.</strong>
</p>

<p align="center">
  <a href="https://flutter.dev/"><img alt="Flutter" src="https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white" /></a>
  <a href="https://dart.dev/"><img alt="Dart" src="https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white" /></a>
  <a href="https://firebase.google.com/"><img alt="Firebase" src="https://img.shields.io/badge/Firebase-DD2C00?logo=firebase&logoColor=white" /></a>
  <img alt="BLoC / Cubit" src="https://img.shields.io/badge/State%20Management-BLoC%20%2F%20Cubit-blueviolet" />
</p>

**Movies App** is a Flutter mobile application for discovering and searching for movies, viewing movie details, and managing a personal watchlist. It combines **Dio** for API communication, **BLoC/Cubit** for state management, and **Firebase Authentication** and **Cloud Firestore** for account and watchlist features.

## 📑 Contents

- [Features](#-features)
- [Screenshots](#-screenshots)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [Running Checks](#-running-checks)
- [Troubleshooting](#-troubleshooting)
- [Contributors](#-contributors)

## ✨ Features

**Movie discovery**
- Explore movies and browse categories.
- Search for movies by title.
- Open individual movie pages to view available information and ratings.

**Authentication and profile**
- Register and log in with Firebase Authentication.
- Sign in with Google.
- Access password recovery and profile-editing screens.

**Personal watchlist**
- Save movies to a personal watchlist.
- Access saved movies, with Cloud Firestore used for cloud storage.

**User experience**
- Onboarding screens introduce the application.
- Dark-themed interface.
- Image loading with `cached_network_image`.
- Reactive UI state handled with BLoC/Cubit.

## 📱 Screenshots

### Movie Discovery

| Home | Movie Details |
|:---:|:---:|
| <img src="screen_shot/home_screen.jpeg" alt="Movies App home screen" width="280" /> | <img src="screen_shot/movie_detiles.jpeg" alt="Movie details screen" width="280" /> |

| Browse / Categories | Search |
|:---:|:---:|
| <img src="screen_shot/brows_screen.jpeg" alt="Browse movies screen" width="280" /> | <img src="screen_shot/search_screeen.jpeg" alt="Movie search screen" width="280" /> |

### Authentication & Profile

| Login | Register | Edit Profile |
|:---:|:---:|:---:|
| <img src="screen_shot/login_screen.jpeg" alt="Login screen" width="220" /> | <img src="screen_shot/register_screen.jpeg" alt="Registration screen" width="220" /> | <img src="screen_shot/edit_profile.jpeg" alt="Edit profile screen" width="220" /> |

### Onboarding

| Screen 1 | Screen 2 | Screen 3 |
|:---:|:---:|:---:|
| <img src="screen_shot/on_boarding1.jpeg" alt="First onboarding screen" width="220" /> | <img src="screen_shot/on_boarding2.jpeg" alt="Second onboarding screen" width="220" /> | <img src="screen_shot/on_boarding3.jpeg" alt="Third onboarding screen" width="220" /> |

## 🛠️ Tech Stack

| Technology | Role |
|---|---|
| **Flutter & Dart** | Cross-platform application development |
| **BLoC / Cubit** (`flutter_bloc`, `bloc`) | State management |
| **Dio** | HTTP requests and movie API communication |
| **Firebase Authentication** | Email/password authentication |
| **Google Sign-In** | Google account login |
| **Cloud Firestore** | Cloud-backed watchlist and application data |
| **flutter_dotenv** | Loading local environment configuration |
| **cached_network_image** | Loading and caching network images |
| **easy_localization** | Localization package included in the project |

## 🏗️ Project Structure

The application separates screens and feature code from shared API, routing, theming, and service helpers. Its BLoC/Cubit components manage UI state independently of widgets.

The following is a **simplified view** of directories and files referenced by the current codebase (not a complete file inventory):

```text
lib/
├── core/
│   ├── api/                 # API-related code and models
│   ├── config/
│   │   ├── routes/          # Named routes and route generation
│   │   └── them/            # App theme
│   └── service/             # Shared UI/service helpers
├── feature/
│   ├── splash/
│   ├── onboarding/
│   ├── login/
│   ├── register/
│   ├── forget_password/
│   ├── edit_profile/
│   └── layout/
│       └── movie_details/
├── firebase_options.dart   # Generated FlutterFire configuration
└── main.dart               # Application entry point
```

## 🚀 Getting Started

### 1. Prerequisites

Install and configure:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) with a Dart version compatible with the project's `pubspec.yaml` (`sdk: ^3.12.2`).
- Android Studio or Visual Studio Code, plus an Android emulator or physical device; Xcode is required for iOS development.
- Git.
- A Firebase project with **Authentication** and **Cloud Firestore** enabled.
- An API key for the movie data service used by the app.

> **Platform note:** The committed `lib/firebase_options.dart` currently contains Firebase options for **Android and iOS**. Other platforms need additional Firebase configuration and may require code changes.

### 2. Clone the repository

```bash
git clone https://github.com/omarazzam25/movies_app.git
cd movies_app
```

### 3. Install Flutter dependencies

```bash
flutter pub get
```

### 4. Configure Firebase

This repository includes generated Firebase configuration associated with the original project. To use **your own Firebase project**, follow the [FlutterFire setup guide](https://firebase.google.com/docs/flutter/setup):

1. Create or select a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
2. Install the [Firebase CLI](https://firebase.google.com/docs/cli) and [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup#install-cli-tools).
3. Log in and configure the Flutter app:

   ```bash
   firebase login
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

4. Select your Firebase project and the target platforms (**Android** and/or **iOS**). This generates or updates `lib/firebase_options.dart` and any required platform configuration.
5. In **Firebase Authentication**, enable the sign-in providers you intend to use (Email/Password and Google).
6. Create a **Cloud Firestore** database and configure appropriate security rules for signed-in users.

For Google Sign-In on Android, check the Firebase instructions for registering your app's **SHA certificate fingerprints** and updating platform configuration.

### 5. Create the environment file

The app calls `dotenv.load(fileName: ".env")` on startup, and `.env` is intentionally excluded from version control. **Create a `.env` file in the project root** (next to `pubspec.yaml`).

The exact environment variable name(s) must match what the app reads from `dotenv.env[...]` or `dotenv.get(...)` in its Dart source. Check those usages before adding your movie API credentials. For example, using **the actual name expected by the source code**:

```dotenv
ACTUAL_VARIABLE_NAME=your_movie_api_key_here
```

`ACTUAL_VARIABLE_NAME` is a placeholder, **not a verified key name**. Do not commit your real `.env` values, API secrets, or private service credentials.

### 6. Run the app

Check available devices and start the app:

```bash
flutter devices
flutter run
```

## ✅ Running Checks

From the project root, you can run:

```bash
flutter analyze
flutter test
```

These are suggested local checks; their successful execution is **not** claimed here.

## 🧰 Troubleshooting

| Problem | What to check |
|---|---|
| App fails when loading `.env` | Ensure `.env` exists at the project root and matches the configuration referenced by `pubspec.yaml`. |
| Movie content does not load | Verify the movie API credential and the **exact** environment variable name expected by the code. |
| Firebase initialization fails | Run `flutterfire configure` for your own Firebase project and verify platform registration. |
| Google Sign-In fails | Check that Google is enabled in Firebase Authentication and Android SHA fingerprints/platform settings are configured. |
| Unsupported Firebase platform | Use the configured Android/iOS targets or add Firebase settings and platform-specific support. |

## 👥 Contributors

Developed collaboratively by:

- **Omar Azzam** — Flutter Developer · [GitHub](https://github.com/omarazzam25) · [LinkedIn](https://www.linkedin.com/in/omar-azzam-1903ab220/)
- **Abdullah Nassar** — Flutter Developer · [GitHub](https://github.com/abdullahnassar2024-pixel)

---

<p align="center">Made with ❤️ using Flutter & Dart.</p>
