import 'package:flutter/material.dart';

import 'device_alignment.dart';

class DeviceClock {
  static const DeviceAlignment defaultAlign = DeviceAlignment.center;
  static const String defaultTime = '10:00';
  static const Color defaultColor = Colors.white;
  static const double defaultFontSize = 11;
  static const Offset defaultOffset = Offset.zero;

  final DeviceAlignment align;
  final String time;
  final Color color;
  final double fontSize;
  final Offset offset;

  const DeviceClock({
    this.align = defaultAlign,
    this.time = defaultTime,
    this.color = defaultColor,
    this.fontSize = defaultFontSize,
    this.offset = defaultOffset,
  });
}
