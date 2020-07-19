import 'package:flutter/material.dart';

import '../device.dart';
import '../device_alignment.dart';
import '../device_battery.dart';
import '../device_body.dart';
import '../device_clock.dart';
import '../device_edge.dart';
import '../device_home_bar.dart';
import '../device_home_button.dart';
import '../device_insets.dart';
import '../device_side_button.dart';
import '../device_wifi.dart';

mixin AppleTablets {
  static final iPad = Device(
    name: 'iPad',
    platform: TargetPlatform.iOS,
    size: const Size(768, 1024),
    devicePixelRatio: 1,
    insets: const DeviceInsets(
      portrait: EdgeInsets.only(top: 20),
      landscape: EdgeInsets.only(top: 20),
    ),
    body: const DeviceBody(
      insets: EdgeInsets.all(100),
      screenRadius: Radius.zero,
      edgeRadius: Radius.circular(56),
      borderSize: 8,
      sideButtons: [
        DeviceSideButton(
          edge: DeviceEdge.top,
          align: DeviceAlignment.end,
          offset: Offset(826, 0),
        ),
        DeviceSideButton(
          offset: Offset(0, 72),
          size: Size(30, 6),
        ),
        DeviceSideButton(
          offset: Offset(0, 130),
        ),
        DeviceSideButton(
          offset: Offset(0, 200),
        ),
      ],
    ),
    clock: const DeviceClock(align: DeviceAlignment.center),
    battery: const DeviceBattery(
      align: DeviceAlignment.end,
      offset: Offset(-10, 0),
      rotation: 1,
    ),
    wifi: const DeviceWifi(
      align: DeviceAlignment.start,
      offset: Offset(10, 0),
    ),
    homeButton: const DeviceHomeButton(hasInnerSquare: true),
  );

  static final iPad2 = iPad.copyWith(
    name: 'iPad 2',
    body: const DeviceBody(
      insets: EdgeInsets.symmetric(horizontal: 88, vertical: 100),
      screenRadius: Radius.zero,
      edgeRadius: Radius.circular(56),
      borderSize: 2,
    ),
  );

  static final iPad3 = iPad2.copyWith(name: 'iPad 3', devicePixelRatio: 2);

  static final iPad4 = iPad.copyWith(name: 'iPad 4');

  static final iPadMini = iPad.copyWith(
    name: 'iPad Mini',
    body: const DeviceBody(
      insets: EdgeInsets.symmetric(horizontal: 32, vertical: 100),
      screenRadius: Radius.zero,
      edgeRadius: Radius.circular(56),
      sideButtons: [
        DeviceSideButton(
          edge: DeviceEdge.top,
          align: DeviceAlignment.end,
          offset: Offset(700, 0),
        ),
        DeviceSideButton(
          offset: Offset(0, 72),
          size: Size(30, 6),
        ),
        DeviceSideButton(
          offset: Offset(0, 130),
        ),
        DeviceSideButton(
          offset: Offset(0, 200),
        ),
      ],
    ),
  );

  static final iPadMini2 = iPadMini.copyWith(
    name: 'iPad Mini 2',
    devicePixelRatio: 2,
  );

  static final iPadMini3 = iPadMini2.copyWith(
    name: 'iPad Mini 3',
    homeButton: const DeviceHomeButton(hasInnerSquare: false),
  );

  static final iPadMini4 = iPadMini3.copyWith(name: 'iPad Mini 4');

  static final iPadAir = iPad3.copyWith(name: 'iPad Air');

  static final iPadAir2 = iPadAir.copyWith(
    name: 'iPad Air 2',
    homeButton: const DeviceHomeButton(hasInnerSquare: false),
  );

  static final iPadAir3 = iPadAir2.copyWith(name: 'iPad Air 3');

  static final iPadPro9_7 = iPadAir2.copyWith(name: 'iPad Pro 9.7');

  static final iPadPro10_5 = iPad3.copyWith(
    name: 'iPad Pro 10.5',
    size: const Size(834, 1112),
    body: iPad3.body.copyWith(
      sideButtons: const [
        DeviceSideButton(
          edge: DeviceEdge.top,
          align: DeviceAlignment.end,
          offset: Offset(880, 0),
        ),
        DeviceSideButton(
          offset: Offset(0, 72),
          size: Size(30, 6),
        ),
        DeviceSideButton(
          offset: Offset(0, 130),
        ),
        DeviceSideButton(
          offset: Offset(0, 200),
        ),
      ],
    ),
    homeButton: const DeviceHomeButton(hasInnerSquare: false),
  );

  static final iPadPro12_9 = iPadPro10_5.copyWith(
    name: 'iPad Pro 12.9',
    size: const Size(1024, 1366),
    body: iPadPro10_5.body.copyWith(
      sideButtons: const [
        DeviceSideButton(
          edge: DeviceEdge.top,
          align: DeviceAlignment.end,
          offset: Offset(1040, 0),
        ),
        DeviceSideButton(
          offset: Offset(0, 72),
          size: Size(30, 6),
        ),
        DeviceSideButton(
          offset: Offset(0, 130),
        ),
        DeviceSideButton(
          offset: Offset(0, 200),
        ),
      ],
    ),
  );

  static final iPadPro11 = iPadPro10_5.remove(homeButton: true).copyWith(
        name: 'iPad Pro 11',
        size: const Size(834, 1194),
        body: const DeviceBody(
          insets: EdgeInsets.all(40),
          screenRadius: Radius.circular(28),
          edgeRadius: Radius.circular(56),
          sideButtons: [
            DeviceSideButton(
              edge: DeviceEdge.top,
              align: DeviceAlignment.end,
              offset: Offset(780, 0),
            ),
            DeviceSideButton(
              offset: Offset(0, 72),
              size: Size(30, 6),
            ),
            DeviceSideButton(
              offset: Offset(0, 130),
            ),
            DeviceSideButton(
              offset: Offset(0, 200),
            ),
          ],
        ),
        homeBar: const DeviceHomeBar(),
        insets: const DeviceInsets(
          portrait: EdgeInsets.only(top: 20, bottom: 34),
          landscape: EdgeInsets.only(top: 20, bottom: 21),
        ),
        clock: const DeviceClock(
          align: DeviceAlignment.start,
          offset: Offset(28, 0),
        ),
        battery: const DeviceBattery(
          align: DeviceAlignment.end,
          offset: Offset(-28, 0),
          rotation: 1,
        ),
        wifi: const DeviceWifi(
          align: DeviceAlignment.end,
          offset: Offset(-48, 0),
        ),
      );

  static final iPadPro12_9Gen3 = iPadPro11.copyWith(
    name: 'iPad Pro 12.9 Gen 3',
    size: const Size(1024, 1366),
    body: iPadPro11.body.copyWith(
      sideButtons: [
        DeviceSideButton(
          edge: DeviceEdge.top,
          align: DeviceAlignment.end,
          offset: Offset(980, 0),
        ),
        DeviceSideButton(
          offset: Offset(0, 72),
          size: Size(30, 6),
        ),
        DeviceSideButton(
          offset: Offset(0, 130),
        ),
        DeviceSideButton(
          offset: Offset(0, 200),
        ),
      ],
    ),
  );
}
