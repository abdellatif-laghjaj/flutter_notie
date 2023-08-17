library flutter_notie;

import 'package:flutter/material.dart';

enum ToastType {
  success,
  info,
  warning,
  error,
  defaultNotie,
}

extension ToastTypeColor on ToastType {
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

class FlutterNotie extends StatelessWidget {
  final String message;
  final Color backgroundColor;

  const FlutterNotie._({
    Key? key,
    required this.message,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
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

  static void success(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 1200)}) {
    _show(context, message, ToastType.success, duration);
  }

  static void info(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 1200)}) {
    _show(context, message, ToastType.info, duration);
  }

  static void warning(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 1200)}) {
    _show(context, message, ToastType.warning, duration);
  }

  static void error(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 1200)}) {
    _show(context, message, ToastType.error, duration);
  }

  static void defaultNotie(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 1200)}) {
    _show(context, message, ToastType.defaultNotie, duration);
  }
}
