import 'package:flutter/material.dart';

import 'device_alignment.dart';
import 'device_battery_level.dart';

class DeviceBattery {
  static const DeviceAlignment defaultAlign = DeviceAlignment.center;
  static const DeviceBatteryLevel defaultLevel = DeviceBatteryLevel.battery30;
  static const Color defaultColor = Colors.white;
  static const double defaultSize = 12;
  static const Offset defaultOffset = Offset.zero;
  static const int defaultRotation = 0;

  final DeviceAlignment align;
  final DeviceBatteryLevel level;
  final Color color;
  final double size;
  final Offset offset;
  final int rotation;

  const DeviceBattery({
    this.align = defaultAlign,
    this.level = defaultLevel,
    this.color = defaultColor,
    this.size = defaultSize,
    this.offset = defaultOffset,
    this.rotation = defaultRotation,
  });
}
