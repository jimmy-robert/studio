import 'package:flutter/material.dart';

class DeviceHomeButton {
  static const Color defaultColor = Colors.grey;
  static const Size defaultSize = Size(64, 64);
  static const BorderRadius defaultBorderRadius = BorderRadius.all(Radius.circular(32));
  static const Offset defaultOffset = Offset.zero;
  static const bool defaultHasInnerSquare = false;
  static const Color defaultInnerSquareColor = Colors.grey;

  final Color color;
  final Size size;
  final BorderRadius borderRadius;
  final Offset offset;
  final bool hasInnerSquare;
  final Color innerSquareColor;

  const DeviceHomeButton({
    this.color = defaultColor,
    this.size = defaultSize,
    this.borderRadius = defaultBorderRadius,
    this.offset = defaultOffset,
    this.hasInnerSquare = defaultHasInnerSquare,
    this.innerSquareColor = defaultInnerSquareColor,
  });
}
