import 'package:flutter/material.dart';

class FlutterNotie extends StatelessWidget {
  final String message;

  const FlutterNotie({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // Fills the width
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      color: Colors.green, // Background color
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center, // Center the text
      ),
    );
  }
}
