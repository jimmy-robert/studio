import 'package:flutter/material.dart';

import 'device_alignment.dart';
import 'device_signal_strength.dart';

class DeviceSignal {
  static const DeviceSignalStrength defaultStrength = DeviceSignalStrength.signal2;
  static const Color defaultColor = Colors.white;
  static const double defaultSize = 12;
  static const DeviceAlignment defaultAlign = DeviceAlignment.center;
  static const Offset defaultOffset = Offset.zero;

  final DeviceSignalStrength strength;
  final Color color;
  final double size;
  final DeviceAlignment align;
  final Offset offset;

  const DeviceSignal({
    this.strength = defaultStrength,
    this.color = defaultColor,
    this.size = defaultSize,
    this.align = defaultAlign,
    this.offset = defaultOffset,
  });
}
