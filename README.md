# Flutter Notie

A Flutter package for displaying stylish toast notifications with ease.

## Features

- Smooth slide-up animations.
- Pre-defined toast styles: success, info, warning, error, and default.
- Customizable duration for the toast to stay on the screen.

## Installation

To add `flutter_notie` to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_notie: ^0.0.1

```

Then install packages from the command line:

```bash
flutter pub get
```
## Usage
To use ```flutter_notie```, simply call one of its static methods in your code:

```dart
// Import the package.
import 'package:flutter_notie/flutter_notie.dart';

// Show a success toast notification.
FlutterNotie.success(context, message: 'This was successful!');

// Show an info toast notification.
FlutterNotie.info(context, message: 'Some information for you.');

// Show a warning toast notification.
FlutterNotie.warning(context, message: 'Be careful!');

// Show an error toast notification.
FlutterNotie.error(context, message: 'Oops, something went wrong.');

// Show a default toast notification.
FlutterNotie.defaultNotie(context, message: 'Just a regular notification.');

// Show a taost notification with a custom duration.
FlutterNotie.success(context, message: 'This was successful!', duration: Duration(seconds: 5));
```