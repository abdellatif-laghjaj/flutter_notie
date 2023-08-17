import 'package:flutter/material.dart';
import 'package:flutter_notie/src/flutter_notie.dart';

class ToastManager {
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void showToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);

    if (_isVisible) return;

    AnimationController controller = AnimationController(
      duration: const Duration(milliseconds: 300),
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
            child: FlutterNotie(message: message),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
    controller.forward();

    _isVisible = true;

    Future.delayed(const Duration(seconds: 2), () {
      controller.reverse().then((value) {
        _overlayEntry?.remove();
        _isVisible = false;
      });
    });
  }
}
