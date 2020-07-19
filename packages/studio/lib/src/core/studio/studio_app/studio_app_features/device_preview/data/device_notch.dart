import 'package:flutter/material.dart';

class DeviceNotch {
  static const Size defaultSize = Size(210, 28);
  static const Radius defaultRadius = Radius.circular(24);
  static const Radius defaultJoinRadius = Radius.circular(12);

  final Size size;
  final Radius radius;
  final Radius joinRadius;

  const DeviceNotch({
    this.size = defaultSize,
    this.radius = defaultRadius,
    this.joinRadius = defaultJoinRadius,
  });
}
