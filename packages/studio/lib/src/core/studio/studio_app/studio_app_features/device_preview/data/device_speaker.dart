import 'package:flutter/material.dart';

class DeviceSpeaker {
  static const Color defaultColor = Colors.grey;
  static const Size defaultSize = Size(64, 8);
  static const Radius defaultRadius = Radius.circular(4);
  static const Offset defaultOffset = Offset.zero;

  final Color color;
  final Size size;
  final Radius radius;
  final Offset offset;

  const DeviceSpeaker({
    this.color = defaultColor,
    this.size = defaultSize,
    this.radius = defaultRadius,
    this.offset = defaultOffset,
  });
}
