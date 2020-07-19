import 'package:flutter/material.dart';

import 'device_alignment.dart';
import 'device_edge.dart';

class DeviceSideButton {
  static const DeviceEdge defaultEdge = DeviceEdge.right;
  static const DeviceAlignment defaultAlign = DeviceAlignment.start;
  static const Offset defaultOffset = Offset(0, 24);
  static const Size defaultSize = Size(60, 6);
  static const Radius defaultRadius = Radius.circular(2);
  static const Color defaultColor = Color(0xFF2B2B2B);

  final DeviceEdge edge;
  final DeviceAlignment align;
  final Offset offset;
  final Size size;
  final Radius radius;
  final Color color;

  const DeviceSideButton({
    this.edge = defaultEdge,
    this.align = defaultAlign,
    this.offset = defaultOffset,
    this.size = defaultSize,
    this.radius = defaultRadius,
    this.color = defaultColor,
  });
}
