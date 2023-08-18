/// Provides sleek toast notifications for Flutter apps with
/// various predefined styles.
library flutter_notie;

import 'dart:ui';

import 'package:flutter/material.dart';

/// An enumeration representing different toast notification types.
enum ToastType {
  success,
  info,
  warning,
  error,
  defaultNotie,
  loading,
}

/// An extension on [ToastType] to easily get the associated color.
extension ToastTypeColor on ToastType {
  /// Returns the color associated with each toast type.
  Color get color {
    switch (this) {
      case ToastType.success:
        return Colors.green.shade700;
      case ToastType.info:
        return Colors.blue.shade700;
      case ToastType.warning:
        return Colors.yellow.shade700;
      case ToastType.error:
        return Colors.red.shade700;
      case ToastType.defaultNotie:
        return Colors.black54;
      case ToastType.loading:
        return Colors.grey.shade800;
    }
  }
}

/// A widget that displays a toast notification on the screen.
class FlutterNotie extends StatelessWidget {
  /// The message to be displayed on the toast.
  final String message;

  /// The background color of the toast.
  final Color backgroundColor;

  /// Creates an instance of [FlutterNotie].
  const FlutterNotie._({
    Key? key,
    required this.message,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        color: backgroundColor.withOpacity(0.8),
        // Making it slightly transparent
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
          overflow: TextOverflow.ellipsis,
          child: (backgroundColor == ToastType.loading.color)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    const SizedBox(width: 15),
                    Text(message, textAlign: TextAlign.center),
                  ],
                )
              : Text(message, textAlign: TextAlign.center),
        ),
      ),
    );
  }

  /// Displays the toast notification on the screen.
  static void _show(BuildContext context, String message, ToastType type,
      Duration duration, Future? futureToWaitFor) {
    final overlay = Overlay.of(context);

    if (_isVisible) return;

    AnimationController controller = AnimationController(
      duration: duration,
      vsync: Navigator.of(context).overlay!,
    );

    Animation<double> opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
    );

    Animation<Offset> positionAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 0,
        child: SlideTransition(
          position: positionAnimation,
          child: FadeTransition(
            opacity: opacityAnimation,
            child:
                FlutterNotie._(message: message, backgroundColor: type.color),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
    controller.forward();

    _isVisible = true;

    Future.delayed(duration, () {
      controller.reverse().then((value) {
        _overlayEntry?.remove();
        _isVisible = false;
      });
    });

    if (type == ToastType.loading && futureToWaitFor != null) {
      futureToWaitFor.then((_) {
        controller.reverse().then((value) {
          _overlayEntry?.remove();
          _isVisible = false;
        });
      });
    } else {
      Future.delayed(duration, () {
        controller.reverse().then((value) {
          _overlayEntry?.remove();
          _isVisible = false;
        });
      });
    }
  }

  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  /// Displays a success toast notification.
  static void success(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 1200)}) {
    _show(context, message, ToastType.success, duration, null);
  }

  /// Displays an informational toast notification.
  static void info(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 1200)}) {
    _show(context, message, ToastType.info, duration, null);
  }

  /// Displays a warning toast notification.
  static void warning(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 1200)}) {
    _show(context, message, ToastType.warning, duration, null);
  }

  /// Displays an error toast notification.
  static void error(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 1200)}) {
    _show(context, message, ToastType.error, duration, null);
  }

  /// Displays a default styled toast notification.
  static void defaultNotie(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 1200)}) {
    _show(context, message, ToastType.defaultNotie, duration, null);
  }

  /// Displays a loading toast notification that waits for a [Future] to complete.
  static void loading(BuildContext context,
      {required String message, required Future futureToWaitFor}) {
    _show(context, message, ToastType.loading, const Duration(days: 365),
        futureToWaitFor); // We give it a very long duration which is effectively cut off when the future completes
  }
}
