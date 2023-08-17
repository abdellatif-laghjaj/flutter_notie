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
import 'package:flutter_notie/flutter_notie.dart';

FlutterNotie.success(context, message: 'This was successful!');
FlutterNotie.info(context, message: 'Some information for you.');
FlutterNotie.warning(context, message: 'Be careful!');
FlutterNotie.error(context, message: 'Oops, something went wrong.');
FlutterNotie.defaultNotie(context, message: 'Just a regular notification.');
```