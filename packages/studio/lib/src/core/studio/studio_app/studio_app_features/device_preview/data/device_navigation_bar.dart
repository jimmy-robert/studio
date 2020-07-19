import 'package:flutter/material.dart';

class DeviceNavigationBar {
  static const Color defaultColor = Colors.black;
  static const Color defaultIconsColor = Color(0xFFBDBDBD);
  static const double defaultIconsSize = 16;
  static const double defaultHeight = 48;

  final Color color;
  final Color iconsColor;
  final double iconsSize;
  final double height;

  const DeviceNavigationBar({
    this.color = defaultColor,
    this.iconsColor = defaultIconsColor,
    this.iconsSize = defaultIconsSize,
    this.height = defaultHeight,
  });
}
