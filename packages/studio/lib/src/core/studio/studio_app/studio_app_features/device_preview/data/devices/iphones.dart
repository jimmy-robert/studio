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
import '../device_notch.dart';
import '../device_side_button.dart';
import '../device_signal.dart';
import '../device_speaker.dart';
import '../device_wifi.dart';

mixin ApplePhones {
  static final iPhone = Device(
    name: 'iPhone',
    platform: TargetPlatform.iOS,
    size: const Size(320, 480),
    devicePixelRatio: 1,
    insets: const DeviceInsets(
      portrait: EdgeInsets.only(top: 20),
      landscape: EdgeInsets.only(top: 20),
    ),
    body: const DeviceBody(
      insets: EdgeInsets.symmetric(horizontal: 26, vertical: 108),
      screenRadius: Radius.zero,
      edgeRadius: Radius.circular(56),
      borderSize: 8,
      sideButtons: [
        DeviceSideButton(
          edge: DeviceEdge.top,
          offset: Offset(260, 0),
        ),
        DeviceSideButton(
          edge: DeviceEdge.left,
          offset: Offset(0, 72),
          size: Size(30, 6),
        ),
        DeviceSideButton(
          edge: DeviceEdge.left,
          offset: Offset(0, 130),
        ),
        DeviceSideButton(
          edge: DeviceEdge.left,
          offset: Offset(0, 200),
        ),
      ],
    ),
    clock: const DeviceClock(),
    battery: DeviceBattery(
      align: DeviceAlignment.end,
      offset: Offset(-10, 0),
      rotation: 1,
    ),
    signal: const DeviceSignal(
      align: DeviceAlignment.start,
      offset: Offset(10, 0),
    ),
    wifi: const DeviceWifi(align: DeviceAlignment.start, offset: Offset(30, 0)),
    speaker: const DeviceSpeaker(
      color: Color(0xFF303030),
      offset: Offset(0, 4),
    ),
    homeButton: const DeviceHomeButton(hasInnerSquare: true),
  );

  static final iPhone3G = iPhone.copyWith(name: 'iPhone 3G');

  static final iPhone3Gs = iPhone.copyWith(name: 'iPhone 3Gs');

  static final iPhone4 = iPhone.copyWith(
    name: 'iPhone 4',
    devicePixelRatio: 2,
    body: iPhone.body.copyWith(
      borderSize: 4,
    ),
  );

  static final iPhone4s = iPhone4.copyWith(name: 'iPhone 4s');

  static final iPhone5 = iPhone4.copyWith(
    name: 'iPhone 5',
    size: const Size(320, 568),
    body: const DeviceBody(
      insets: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: 26,
      ),
      screenRadius: Radius.zero,
      edgeRadius: Radius.circular(56),
      borderSize: 1,
      sideButtons: [
        DeviceSideButton(
          edge: DeviceEdge.right,
          offset: Offset(0, 160),
        ),
        DeviceSideButton(
          edge: DeviceEdge.left,
          offset: Offset(0, 100),
          size: Size(35, 6),
        ),
        DeviceSideButton(
          edge: DeviceEdge.left,
          offset: Offset(0, 160),
        ),
        DeviceSideButton(
          edge: DeviceEdge.left,
          offset: Offset(0, 230),
        ),
      ],
    ),
  );

  static final iPhone5s = iPhone5.copyWith(name: 'iPhone 5s');

  static final iPhone5c = iPhone5.copyWith(
    name: 'iPhone 5c',
    body: iPhone5.body.copyWith(
      borderColor: Colors.white,
    ),
  );

  static final iPhoneSE = iPhone5.copyWith(
    name: 'iPhone SE',
    homeButton: const DeviceHomeButton(),
  );

  static final iPhone6 = iPhone5.copyWith(
    name: 'iPhone 6',
    size: const Size(375, 667),
    homeButton: const DeviceHomeButton(),
  );

  static final iPhone6Plus = iPhone6.copyWith(
    name: 'iPhone 6+',
    size: const Size(414, 736),
    devicePixelRatio: 3,
  );

  static final iPhone6s = iPhone6.copyWith(name: 'iPhone 6s');

  static final iPhone6sPlus = iPhone6Plus.copyWith(name: 'iPhone 6s+');

  static final iPhone7 = iPhone6.copyWith(name: 'iPhone 7');

  static final iPhone7Plus = iPhone6Plus.copyWith(name: 'iPhone 7+');

  static final iPhone8 = iPhone6.copyWith(name: 'iPhone 8');

  static final iPhone8Plus = iPhone6Plus.copyWith(name: 'iPhone 8+');

  static final iPhoneX = iPhone6.remove(homeButton: true).copyWith(
        name: 'iPhone X',
        size: const Size(375, 812),
        devicePixelRatio: 3,
        body: const DeviceBody(
          insets: EdgeInsets.all(18),
          edgeRadius: Radius.circular(56),
          screenRadius: Radius.circular(38),
          sideButtons: [
            DeviceSideButton(
              edge: DeviceEdge.left,
              offset: Offset(0, 116),
              size: Size(35, 6),
            ),
            DeviceSideButton(
              edge: DeviceEdge.left,
              offset: Offset(0, 176),
            ),
            DeviceSideButton(
              edge: DeviceEdge.left,
              offset: Offset(0, 240),
            ),
            DeviceSideButton(
              edge: DeviceEdge.right,
              offset: Offset(0, 176),
              size: Size(90, 6),
            ),
          ],
        ),
        insets: const DeviceInsets(
          portrait: EdgeInsets.only(
            top: 44,
            bottom: 34,
          ),
          landscape: EdgeInsets.only(
            left: 44,
            right: 44,
            bottom: 21,
          ),
        ),
        notch: const DeviceNotch(),
        speaker: DeviceSpeaker(
          color: Colors.grey.shade900,
          offset: Offset(0, 20),
        ),
        homeBar: const DeviceHomeBar(),
        clock: const DeviceClock(
          align: DeviceAlignment.start,
          fontSize: 14,
          offset: Offset(28, -4),
        ),
        battery: const DeviceBattery(
          rotation: 1,
          align: DeviceAlignment.end,
          size: 20,
          offset: Offset(-16, -4),
        ),
        wifi: const DeviceWifi(
          align: DeviceAlignment.end,
          size: 16,
          offset: Offset(-44, -4),
        ),
        signal: const DeviceSignal(
          align: DeviceAlignment.end,
          size: 16,
          offset: Offset(-68, -4),
        ),
      );

  static final iPhoneXr = iPhoneX.copyWith(
    name: 'iPhone Xr',
    size: const Size(414, 896),
    devicePixelRatio: 2,
    clock: const DeviceClock(
      align: DeviceAlignment.start,
      fontSize: 14,
      offset: Offset(36, -4),
    ),
    battery: const DeviceBattery(
      rotation: 1,
      align: DeviceAlignment.end,
      size: 20,
      offset: Offset(-24, -4),
    ),
    wifi: const DeviceWifi(
      align: DeviceAlignment.end,
      size: 16,
      offset: Offset(-52, -4),
    ),
    signal: const DeviceSignal(
      align: DeviceAlignment.end,
      size: 16,
      offset: Offset(-76, -4),
    ),
  );

  static final iPhoneXs = iPhoneX.copyWith(name: 'iPhone Xs');

  static final iPhoneXsMax = iPhoneXr.copyWith(
    name: 'iPhone Xs Max',
    size: const Size(414, 896),
    devicePixelRatio: 3,
  );

  static final iPhone11 = iPhoneXr.copyWith(name: 'iPhone 11');

  static final iPhone11Pro = iPhoneXs.copyWith(name: 'iPhone 11 Pro');

  static final iPhone11ProMax = iPhoneXsMax.copyWith(name: 'iPhone 11 Pro Max');

  static final iPhoneSEGen2 = iPhone8.copyWith(name: 'iPhone SE Gen 2');
}
