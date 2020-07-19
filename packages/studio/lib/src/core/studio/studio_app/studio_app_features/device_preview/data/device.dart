import 'dart:ui';

import 'package:flutter/material.dart';

import 'device_battery.dart';
import 'device_body.dart';
import 'device_clock.dart';
import 'device_cutout.dart';
import 'device_home_bar.dart';
import 'device_home_button.dart';
import 'device_insets.dart';
import 'device_keyboard.dart';
import 'device_navigation_bar.dart';
import 'device_notch.dart';
import 'device_signal.dart';
import 'device_speaker.dart';
import 'device_status_bar.dart';
import 'device_wifi.dart';

class Device {
  final String name;
  final TargetPlatform platform;
  final Size size;
  final DeviceInsets insets;
  final double devicePixelRatio;
  final DeviceBody body;
  final DeviceNotch notch;
  final DeviceKeyboard keyboard;
  final DeviceNavigationBar navigationBar;
  final DeviceHomeBar homeBar;
  final DeviceClock clock;
  final DeviceBattery battery;
  final DeviceStatusBar statusBar;
  final DeviceSignal signal;
  final DeviceWifi wifi;
  final DeviceCutout cutout;
  final DeviceSpeaker speaker;
  final DeviceHomeButton homeButton;

  const Device({
    this.name,
    @required this.platform,
    @required this.size,
    this.insets = const DeviceInsets(),
    this.devicePixelRatio = 1,
    this.body = const DeviceBody(),
    this.keyboard = const DeviceKeyboard(),
    this.notch,
    this.navigationBar,
    this.homeBar,
    this.clock,
    this.battery,
    this.statusBar,
    this.signal,
    this.wifi,
    this.cutout,
    this.speaker,
    this.homeButton,
  });

  Device copyWith({
    String name,
    TargetPlatform platform,
    Size size,
    DeviceInsets insets,
    double devicePixelRatio,
    DeviceBody body,
    DeviceNotch notch,
    DeviceKeyboard keyboard,
    DeviceNavigationBar navigationBar,
    DeviceHomeBar homeBar,
    DeviceClock clock,
    DeviceBattery battery,
    DeviceStatusBar statusBar,
    DeviceSignal signal,
    DeviceWifi wifi,
    DeviceCutout cutout,
    DeviceSpeaker speaker,
    DeviceHomeButton homeButton,
  }) {
    return Device(
      name: name ?? this.name,
      platform: platform ?? this.platform,
      size: size ?? this.size,
      insets: insets ?? this.insets,
      devicePixelRatio: devicePixelRatio ?? this.devicePixelRatio,
      body: body ?? this.body,
      notch: notch ?? this.notch,
      keyboard: keyboard ?? this.keyboard,
      navigationBar: navigationBar ?? this.navigationBar,
      homeBar: homeBar ?? this.homeBar,
      clock: clock ?? this.clock,
      battery: battery ?? this.battery,
      statusBar: statusBar ?? this.statusBar,
      signal: signal ?? this.signal,
      wifi: wifi ?? this.wifi,
      cutout: cutout ?? this.cutout,
      speaker: speaker ?? this.speaker,
      homeButton: homeButton ?? this.homeButton,
    );
  }

  Device remove({
    bool name = false,
    bool platform = false,
    bool size = false,
    bool insets = false,
    bool devicePixelRatio = false,
    bool body = false,
    bool notch = false,
    bool keyboard = false,
    bool navigationBar = false,
    bool homeBar = false,
    bool clock = false,
    bool battery = false,
    bool statusBar = false,
    bool signal = false,
    bool wifi = false,
    bool cutout = false,
    bool speaker = false,
    bool homeButton = false,
  }) {
    return Device(
      name: name ? null : this.name,
      platform: platform ? null : this.platform,
      size: size ? null : this.size,
      insets: insets ? null : this.insets,
      devicePixelRatio: devicePixelRatio ? null : this.devicePixelRatio,
      body: body ? null : this.body,
      notch: notch ? null : this.notch,
      keyboard: keyboard ? null : this.keyboard,
      navigationBar: navigationBar ? null : this.navigationBar,
      homeBar: homeBar ? null : this.homeBar,
      clock: clock ? null : this.clock,
      battery: battery ? null : this.battery,
      statusBar: statusBar ? null : this.statusBar,
      signal: signal ? null : this.signal,
      wifi: wifi ? null : this.wifi,
      cutout: cutout ? null : this.cutout,
      speaker: speaker ? null : this.speaker,
      homeButton: homeButton ? null : this.homeButton,
    );
  }
}
