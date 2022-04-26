# Flutter Movie Database


Movie Database app is a Flutter app project that allows users to search for a movie or tv series, see the detail, season & episode, and save watchlist. The movies and tv series data is gotten from https://www.themoviedb.org/

![alt text](art/demo.gif)

## Prerequisites

Before begin to install to your local machine and test it, make sure you have met the following requirements:
* You have installed the latest version of Flutter SDK. [Install Flutter](https://docs.flutter.dev/get-started/install)
* You have installed Android Studio and setup an emulator. [Download Android Studio](https://developer.android.com/studio)
* You have installed XCode 13 and setup a simulator (if you are using macOS)

## Run for the first time
After load the project to your local machine IDE, follow these steps:

Restore the package
```
flutter pub get
```

Run
```
flutter run
```

To use your own TMDB API Key, you can edit this line on the file inside lib/common/urls.dart:
```dart
class Urls {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'api_key=YOUR_API_KEY';
  ...
}
```

## Core concepts this project used

* Clean Architecture 🏗️
* Test-Driven Development (TDD) - Unit, Widget, and Integration tests 🧪
* Advanced UI 🏙️
* Modularity

## 🔥 Contributing to [This project](https://github.com/codestronautHub/flutter-movie-database-app)

If you are currently learning Flutter development and want to start contributing to open source, let's get started! To contribute to this project, follow these steps:

1. Fork this repository
2. Create a new branch: `git checkout -b <branch_name>`
3. Make your changes and commit them: `git commit -m '<commit_message>'`. Please follow this [Commit Style Guide](https://mauss.dev/posts/semantic-commit-message)
4. Push your changes to the original branch on your repository
5. Create the PR (Pull Request)

To contributing to this project, you can explore [TMDB API Docs](https://developers.themoviedb.org/3) and start add a new feature that intresting and useful for cinephile.

IMPORTANT: You must follow the clean architecture and TDD proccess to add a new feature.

Thanks 😊
