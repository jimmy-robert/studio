import 'package:flutter/material.dart';

import '../device.dart';
import '../device_alignment.dart';
import '../device_battery.dart';
import '../device_body.dart';
import '../device_clock.dart';
import '../device_edge.dart';
import '../device_insets.dart';
import '../device_navigation_bar.dart';
import '../device_side_button.dart';
import '../device_signal.dart';
import '../device_speaker.dart';
import '../device_status_bar.dart';
import '../device_wifi.dart';

mixin GooglePhones {
  static final pixel = Device(
    name: 'Google Pixel',
    platform: TargetPlatform.android,
    devicePixelRatio: 2.6,
    size: const Size(411, 731),
    body: const DeviceBody(
      insets: EdgeInsets.symmetric(vertical: 88, horizontal: 16),
      edgeRadius: Radius.circular(44),
      screenRadius: Radius.circular(0),
      borderSize: 2,
      sideButtons: [
        DeviceSideButton(
          edge: DeviceEdge.right,
          offset: Offset(0, 220),
          size: Size(54, 4),
        ),
        DeviceSideButton(
          edge: DeviceEdge.right,
          offset: Offset(0, 338),
          size: Size(120, 4),
        ),
      ],
    ),
    speaker: DeviceSpeaker(color: Colors.grey.shade800),
    navigationBar: const DeviceNavigationBar(),
    insets: const DeviceInsets(
      portrait: EdgeInsets.only(top: 24),
      landscape: EdgeInsets.only(top: 24),
    ),
    statusBar: const DeviceStatusBar(),
    clock: const DeviceClock(
      align: DeviceAlignment.start,
      offset: Offset(12, 0),
    ),
    battery: DeviceBattery(
      align: DeviceAlignment.end,
      offset: Offset(-10, 0),
    ),
    signal: DeviceSignal(
      align: DeviceAlignment.end,
      offset: Offset(-26, 0),
    ),
    wifi: DeviceWifi(
      align: DeviceAlignment.end,
      offset: Offset(-42, 0),
    ),
  );

  static final pixelXl = pixel.copyWith(
    name: 'Google Pixel XL',
    devicePixelRatio: 3.5,
  );

  static final nexus4 = pixel.copyWith(
    name: 'Nexus 4',
    size: const Size(384, 640),
    body: const DeviceBody(
      insets: EdgeInsets.symmetric(vertical: 88, horizontal: 16),
      edgeRadius: Radius.elliptical(108, 64),
      screenRadius: Radius.circular(0),
      borderSize: 4,
    ),
    speaker: DeviceSpeaker(color: Color(0xFF2A2A2A), offset: Offset(0, -32)),
  );

  static final nexus5 = nexus4.copyWith(
    name: 'Nexus 5',
    size: const Size(360, 640),
    devicePixelRatio: 3,
    body: const DeviceBody(
      insets: EdgeInsets.only(top: 64, left: 16, right: 16, bottom: 82),
      edgeRadius: Radius.elliptical(56, 38),
      screenRadius: Radius.circular(0),
    ),
    speaker: DeviceSpeaker(
      color: Colors.grey.shade800,
      size: Size(8, 8),
    ),
  );

  static final nexus6 = nexus5.copyWith(
    name: 'Nexus 6',
    size: const Size(411, 731),
    devicePixelRatio: 3.5,
    speaker: DeviceSpeaker(color: Color(0xFF2A2A2A), size: Size(120, 8)),
    body: const DeviceBody(
      insets: EdgeInsets.symmetric(vertical: 56, horizontal: 16),
      edgeRadius: Radius.elliptical(192, 32),
      screenRadius: Radius.circular(0),
    ),
  );

  static final nexus5x = nexus6.copyWith(
    name: 'Nexus 5X',
    size: const Size(411, 731),
    devicePixelRatio: 2.6,
    body: const DeviceBody(
      insets: EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      edgeRadius: Radius.circular(44),
      screenRadius: Radius.circular(0),
    ),
  );
}
