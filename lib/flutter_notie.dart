/// Provides sleek toast notifications for Flutter apps with
/// various predefined styles.
library flutter_notie;

import 'package:flutter/material.dart';

/// An enumeration representing different toast notification types.
enum ToastType {
  success,
  info,
  warning,
  error,
  defaultNotie,
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
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      color: backgroundColor,
      child: DefaultTextStyle(
        style: const TextStyle(color: Colors.white, fontSize: 16.0),
        overflow: TextOverflow.ellipsis,
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  /// Displays the toast notification on the screen.
  static void _show(
      BuildContext context, String message, ToastType type, Duration duration) {
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
  }

  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  /// Displays a success toast notification.
  static void success(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 1200)}) {
    _show(context, message, ToastType.success, duration);
  }

  /// Displays an informational toast notification.
  static void info(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 1200)}) {
    _show(context, message, ToastType.info, duration);
  }

  /// Displays a warning toast notification.
  static void warning(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 1200)}) {
    _show(context, message, ToastType.warning, duration);
  }

  /// Displays an error toast notification.
  static void error(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 1200)}) {
    _show(context, message, ToastType.error, duration);
  }

  /// Displays a default styled toast notification.
  static void defaultNotie(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 1200)}) {
    _show(context, message, ToastType.defaultNotie, duration);
  }
}
