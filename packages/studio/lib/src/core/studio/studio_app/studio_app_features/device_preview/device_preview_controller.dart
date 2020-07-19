import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'data/device.dart';

class DevicePreviewController {
  final enabled = Observable(true);

  final device = Observable(const Device(
    platform: TargetPlatform.iOS,
    size: Size(414, 896),
  ));

  final orientation = Observable(Orientation.portrait);

  final isKeyboardVisible = Observable(false);

  final fullscreen = Observable(false);
}
