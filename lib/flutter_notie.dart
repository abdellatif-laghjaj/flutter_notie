library flutter_notie;

import 'package:flutter/material.dart';

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
      BuildContext context, FlutterNotie notie, Duration duration) {
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
            child: notie,
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
      Duration duration = const Duration(milliseconds: 800)}) {
    _show(
        context,
        FlutterNotie._(
            message: message, backgroundColor: Colors.green.shade700),
        duration);
  }

  static void info(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 800)}) {
    _show(
        context,
        FlutterNotie._(message: message, backgroundColor: Colors.blue.shade700),
        duration);
  }

  static void warning(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 800)}) {
    _show(
        context,
        FlutterNotie._(
            message: message, backgroundColor: Colors.yellow.shade700),
        duration);
  }

  static void error(BuildContext context,
      {required String message,
      Duration duration = const Duration(milliseconds: 800)}) {
    _show(
        context,
        FlutterNotie._(message: message, backgroundColor: Colors.red.shade700),
        duration);
  }

  static void defaultNotie(BuildContext context,
      {required String message,
      Duration duration = const Duration(seconds: 2)}) {
    _show(
        context,
        FlutterNotie._(message: message, backgroundColor: Colors.black54),
        duration);
  }
}
