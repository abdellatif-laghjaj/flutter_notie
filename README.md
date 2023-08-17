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

## Screenshots
![image](https://github.com/abdellatif-laghjaj/flutter_notie/assets/79521157/812f9750-4181-4ad5-9c7f-0501dc7a4d24)
![image](https://github.com/abdellatif-laghjaj/flutter_notie/assets/79521157/2305c3ee-4b69-4d95-ba81-0423402bca71)
![image](https://github.com/abdellatif-laghjaj/flutter_notie/assets/79521157/5f6ef0ff-ae18-4616-8a43-d90079c1768a)
![image](https://github.com/abdellatif-laghjaj/flutter_notie/assets/79521157/e23e0204-dd6d-49b3-bafa-014e924bc674)
![image](https://github.com/abdellatif-laghjaj/flutter_notie/assets/79521157/dead9424-e383-4c56-8f71-a87381eabdb2)



