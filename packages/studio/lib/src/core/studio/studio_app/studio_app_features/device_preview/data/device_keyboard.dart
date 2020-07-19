import 'package:flutter/material.dart';

class DeviceKeyboard {
  static const double defaultHeight = 214;
  static const Color defaultBackgroundColor = Color(0xDD2B2B2D);
  static const Color defaultButton1BackgroundColor = Color(0xFF6D6D6E);
  static const Color defaultButton1ForegroundColor = Colors.white;
  static const Color defaultButton2BackgroundColor = Color(0xFF4A4A4B);
  static const Color defaultButton2ForegroundColor = Colors.white;

  final double height;
  final Color backgroundColor;
  final Color button1BackgroundColor;
  final Color button1ForegroundColor;
  final Color button2BackgroundColor;
  final Color button2ForegroundColor;

  const DeviceKeyboard({
    this.height = defaultHeight,
    this.backgroundColor = defaultBackgroundColor,
    this.button1BackgroundColor = defaultButton1BackgroundColor,
    this.button1ForegroundColor = defaultButton1ForegroundColor,
    this.button2BackgroundColor = defaultButton2BackgroundColor,
    this.button2ForegroundColor = defaultButton2ForegroundColor,
  });
}
