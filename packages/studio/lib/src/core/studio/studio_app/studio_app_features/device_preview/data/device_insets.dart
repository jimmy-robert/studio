import 'package:flutter/material.dart';

class DeviceInsets {
  final EdgeInsets portrait;
  final EdgeInsets landscape;

  const DeviceInsets({
    this.portrait = EdgeInsets.zero,
    this.landscape = EdgeInsets.zero,
  });
}
