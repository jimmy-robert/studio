import 'dart:ui';

import 'package:flutter/material.dart';

import 'device_alignment.dart';

class DeviceCutout {
  static const Size defaultSize = Size(16, 16);
  static const DeviceAlignment defaultAlign = DeviceAlignment.center;
  static const Radius defaultRadius = Radius.circular(8);
  static const Offset defaultOffset = Offset.zero;

  final Size size;
  final DeviceAlignment align;
  final Radius radius;
  final Offset offset;

  const DeviceCutout({
    this.size = defaultSize,
    this.align = defaultAlign,
    this.radius = defaultRadius,
    this.offset = defaultOffset,
  });
}
