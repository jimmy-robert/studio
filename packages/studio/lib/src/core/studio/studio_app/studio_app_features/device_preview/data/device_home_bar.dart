import 'package:flutter/material.dart';

class DeviceHomeBar {
  static const Color defaultColor = Colors.black;
  static const Size defaultSize = Size(132, 6);

  final Color color;
  final Size size;

  const DeviceHomeBar({
    this.color = defaultColor,
    this.size = defaultSize,
  });
}
