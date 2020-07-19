import 'package:flutter/material.dart';

import '../device.dart';
import '../device_alignment.dart';
import '../device_battery.dart';
import '../device_battery_level.dart';
import '../device_body.dart';
import '../device_clock.dart';
import '../device_cutout.dart';
import '../device_edge.dart';
import '../device_home_bar.dart';
import '../device_home_button.dart';
import '../device_keyboard.dart';
import '../device_navigation_bar.dart';
import '../device_notch.dart';
import '../device_side_button.dart';
import '../device_signal.dart';
import '../device_signal_strength.dart';
import '../device_speaker.dart';
import '../device_status_bar.dart';
import '../device_wifi.dart';
import '../device_wifi_strength.dart';

mixin DeviceSerializer {
  static Map<String, dynamic> serializeDevice(Device device) {
    return <String, dynamic>{
      'name': device.name,
      'platform': serializePlatform(device.platform),
      'size': serializeSize(device.size),
      'devicePixelRatio': device.devicePixelRatio,
      'body': serializeBody(device.body),
      'notch': serializeNotch(device.notch),
      'keyboard': serializeKeyboard(device.keyboard),
      'navigationBar': serializeNavigationBar(device.navigationBar),
      'homeBar': serializeHomeBar(device.homeBar),
      'clock': serializeClock(device.clock),
      'battery': serializeBattery(device.battery),
      'statusBar': serializeStatusBar(device.statusBar),
      'signal': serializeSignal(device.signal),
      'wifi': serializeWifi(device.wifi),
      'cutout': serializeCutout(device.cutout),
      'speaker': serializeSpeaker(device.speaker),
      'homeButton': serializeHomeButton(device.homeButton),
    };
  }

  static Device deserializeDevice(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return Device(
      name: data['name'] as String,
      platform: deserializePlatform(data['platform']),
      size: deserializeSize(data['size']),
      devicePixelRatio: deserializeDouble(data['devicePixelRatio']),
      body: deserializeBody(data['body']),
      notch: deserializeNotch(data['notch']),
      keyboard: deserializeKeyboard(data['keyboard']),
      navigationBar: deserializeNavigationBar(data['navigationBar']),
      homeBar: deserializeHomeBar(data['homeBar']),
      clock: deserializeClock(data['clock']),
      battery: deserializeBattery(data['battery']),
      statusBar: deserializeStatusBar(data['statusBar']),
      signal: deserializeSignal(data['signal']),
      wifi: deserializeWifi(data['wifi']),
      cutout: deserializeCutout(data['cutout']),
      speaker: deserializeSpeaker(data['speaker']),
      homeButton: deserializeHomeButton(data['homeButton']),
    );
  }

  static double deserializeDouble(dynamic value) {
    if (value == null) return null;
    return (value as num).toDouble();
  }

  static Map<String, dynamic> serializeSize(Size size) {
    if (size == null) return null;
    return <String, dynamic>{
      'width': size.width,
      'height': size.height,
    };
  }

  static Size deserializeSize(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return Size(
      deserializeDouble(data['width']),
      deserializeDouble(data['height']),
    );
  }

  static Map<String, dynamic> serializeOffset(Offset offset) {
    if (offset == null) return null;
    return <String, dynamic>{
      'dx': offset.dx,
      'dy': offset.dy,
    };
  }

  static Offset deserializeOffset(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return Offset(
      deserializeDouble(data['dx']),
      deserializeDouble(data['dy']),
    );
  }

  static DeviceBody deserializeBody(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return DeviceBody(
      color: deserializeColor(data['color']),
      edgeRadius: deserializeRadius(data['edgeRadius']),
      screenRadius: deserializeRadius(data['screenRadius']),
      insets: deserializeInsets(data['insets']),
      borderColor: deserializeColor(data['borderColor']),
      borderSize: deserializeDouble(data['borderSize']),
      sideButtons: deserializeSideButtons(data['sideButtons']),
    );
  }

  static Map<String, dynamic> serializeBody(DeviceBody body) {
    if (body == null) return null;
    return <String, dynamic>{
      'color': body.color.value,
      'edgeRadius': serializeRadius(body.edgeRadius),
      'screenRadius': serializeRadius(body.screenRadius),
      'insets': serializeInsets(body.insets),
      'borderColor': serializeColor(body.borderColor),
      'borderSize': body.borderSize,
      'sideButtons': serializeSideButtons(body.sideButtons),
    };
  }

  static EdgeInsets deserializeInsets(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return EdgeInsets.fromLTRB(
      deserializeDouble(data['left']),
      deserializeDouble(data['top']),
      deserializeDouble(data['right']),
      deserializeDouble(data['bottom']),
    );
  }

  static Map<String, dynamic> serializeInsets(EdgeInsets insets) {
    if (insets == null) return null;
    return <String, dynamic>{
      'left': insets.left,
      'top': insets.top,
      'right': insets.right,
      'bottom': insets.bottom,
    };
  }

  static Radius deserializeRadius(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return Radius.elliptical(
      deserializeDouble(data['x']),
      deserializeDouble(data['y']),
    );
  }

  static Map<String, dynamic> serializeRadius(Radius radius) {
    if (radius == null) return null;
    return <String, dynamic>{
      'x': radius.x,
      'y': radius.y,
    };
  }

  static BorderRadius deserializeBorderRadius(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return BorderRadius.only(
      topLeft: deserializeRadius(data['topLeft']),
      topRight: deserializeRadius(data['topRight']),
      bottomRight: deserializeRadius(data['bottomRight']),
      bottomLeft: deserializeRadius(data['bottomLeft']),
    );
  }

  static Map<String, dynamic> serializeBorderRadius(BorderRadius radius) {
    if (radius == null) return null;
    return <String, dynamic>{
      'topLeft': serializeRadius(radius.topLeft),
      'topRight': serializeRadius(radius.topRight),
      'bottomRight': serializeRadius(radius.bottomRight),
      'bottomLeft': serializeRadius(radius.bottomLeft),
    };
  }

  static List<DeviceSideButton> deserializeSideButtons(dynamic data) {
    if (data is List<dynamic>) return data.map((dynamic item) => deserializeSideButton(item)).toList();
    return null;
  }

  static List<dynamic> serializeSideButtons(List<DeviceSideButton> buttons) {
    if (buttons == null) return null;
    return buttons.map((button) => serializeSideButton(button)).toList();
  }

  static DeviceSideButton deserializeSideButton(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return DeviceSideButton(
      edge: deserializeEdge(data['edge']),
      align: deserializeAlignment(data['align']),
      offset: deserializeOffset(data['offset']),
      size: deserializeSize(data['size']),
      radius: deserializeRadius(data['radius']),
      color: deserializeColor(data['color']),
    );
  }

  static Map<String, dynamic> serializeSideButton(DeviceSideButton button) {
    if (button == null) return null;
    return <String, dynamic>{
      'edge': serializeEdge(button.edge),
      'align': serializeAlignment(button.align),
      'offset': serializeOffset(button.offset),
      'size': serializeSize(button.size),
      'radius': serializeRadius(button.radius),
      'color': serializeColor(button.color),
    };
  }

  static DeviceNotch deserializeNotch(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return DeviceNotch(
      size: deserializeSize(data['size']),
      radius: deserializeRadius(data['radius']),
      joinRadius: deserializeRadius(data['joinRadius']),
    );
  }

  static Map<String, dynamic> serializeNotch(DeviceNotch notch) {
    if (notch == null) return null;
    return <String, dynamic>{
      'size': serializeSize(notch.size),
      'radius': serializeRadius(notch.radius),
      'joinRadius': serializeRadius(notch.joinRadius),
    };
  }

  static DeviceKeyboard deserializeKeyboard(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return DeviceKeyboard(
      height: deserializeDouble(data['height']),
      backgroundColor: deserializeColor(data['backgroundColor']),
      button1BackgroundColor: deserializeColor(data['button1BackgroundColor']),
      button1ForegroundColor: deserializeColor(data['button1ForegroundColor']),
      button2BackgroundColor: deserializeColor(data['button2BackgroundColor']),
      button2ForegroundColor: deserializeColor(data['button2ForegroundColor']),
    );
  }

  static Map<String, dynamic> serializeKeyboard(DeviceKeyboard keyboard) {
    if (keyboard == null) return null;
    return <String, dynamic>{
      'height': keyboard.height,
      'backgroundColor': serializeColor(keyboard.backgroundColor),
      'button1BackgroundColor': serializeColor(keyboard.button1BackgroundColor),
      'button1ForegroundColor': serializeColor(keyboard.button1ForegroundColor),
      'button2BackgroundColor': serializeColor(keyboard.button2BackgroundColor),
      'button2ForegroundColor': serializeColor(keyboard.button2ForegroundColor),
    };
  }

  static DeviceNavigationBar deserializeNavigationBar(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return DeviceNavigationBar(
      color: deserializeColor(data['color']),
      iconsColor: deserializeColor(data['iconsColor']),
      iconsSize: deserializeDouble(data['iconsSize']),
      height: deserializeDouble(data['height']),
    );
  }

  static Map<String, dynamic> serializeNavigationBar(DeviceNavigationBar navigationBar) {
    if (navigationBar == null) return null;
    return <String, dynamic>{
      'color': serializeColor(navigationBar.color),
      'iconsColor': serializeColor(navigationBar.iconsColor),
      'iconsSize': navigationBar.iconsSize,
      'height': navigationBar.height,
    };
  }

  static DeviceHomeBar deserializeHomeBar(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return DeviceHomeBar(
      color: deserializeColor(data['color']),
      size: deserializeSize(data['size']),
    );
  }

  static Map<String, dynamic> serializeHomeBar(DeviceHomeBar homeBar) {
    if (homeBar == null) return null;
    return <String, dynamic>{
      'color': serializeColor(homeBar.color),
      'size': serializeSize(homeBar.size),
    };
  }

  static DeviceClock deserializeClock(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return DeviceClock(
      align: deserializeAlignment(data['align']),
      time: data['time'] as String,
      color: deserializeColor(data['color']),
      fontSize: deserializeDouble(data['fontSize']),
      offset: deserializeOffset(data['offset']),
    );
  }

  static Map<String, dynamic> serializeClock(DeviceClock clock) {
    if (clock == null) return null;
    return <String, dynamic>{
      'align': serializeAlignment(clock.align),
      'time': clock.time,
      'color': serializeColor(clock.color),
      'fontSize': clock.fontSize,
      'offset': serializeOffset(clock.offset),
    };
  }

  static DeviceBattery deserializeBattery(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return DeviceBattery(
      align: deserializeAlignment(data['align']),
      level: deserializeBatteryLevel(data['level']),
      color: deserializeColor(data['color']),
      size: deserializeDouble(data['size']),
      offset: deserializeOffset(data['offset']),
      rotation: deserializeDouble(data['rotation']).toInt(),
    );
  }

  static Map<String, dynamic> serializeBattery(DeviceBattery battery) {
    if (battery == null) return null;
    return <String, dynamic>{
      'align': serializeAlignment(battery.align),
      'level': serializeBatteryLevel(battery.level),
      'color': serializeColor(battery.color),
      'size': battery.size,
      'offset': serializeOffset(battery.offset),
      'rotation': battery.rotation,
    };
  }

  static DeviceSignal deserializeSignal(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return DeviceSignal(
      strength: deserializeSignalStrength(data['strength']),
      color: deserializeColor(data['color']),
      size: deserializeDouble(data['size']),
      align: deserializeAlignment(data['align']),
      offset: deserializeOffset(data['offset']),
    );
  }

  static Map<String, dynamic> serializeSignal(DeviceSignal battery) {
    if (battery == null) return null;
    return <String, dynamic>{
      'strength': serializeSignalStrength(battery.strength),
      'color': serializeColor(battery.color),
      'size': battery.size,
      'align': serializeAlignment(battery.align),
      'offset': serializeOffset(battery.offset),
    };
  }

  static DeviceWifi deserializeWifi(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return DeviceWifi(
      strength: deserializeWifiStrength(data['strength']),
      color: deserializeColor(data['color']),
      size: deserializeDouble(data['size']),
      align: deserializeAlignment(data['align']),
      offset: deserializeOffset(data['offset']),
    );
  }

  static Map<String, dynamic> serializeWifi(DeviceWifi battery) {
    if (battery == null) return null;
    return <String, dynamic>{
      'strength': serializeWifiStrength(battery.strength),
      'color': serializeColor(battery.color),
      'size': battery.size,
      'align': serializeAlignment(battery.align),
      'offset': serializeOffset(battery.offset),
    };
  }

  static DeviceCutout deserializeCutout(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return DeviceCutout(
      size: deserializeSize(data['size']),
      align: deserializeAlignment(data['align']),
      radius: deserializeRadius(data['radius']),
      offset: deserializeOffset(data['offset']),
    );
  }

  static Map<String, dynamic> serializeCutout(DeviceCutout cutout) {
    if (cutout == null) return null;
    return <String, dynamic>{
      'size': serializeSize(cutout.size),
      'align': serializeAlignment(cutout.align),
      'radius': serializeRadius(cutout.radius),
      'offset': serializeOffset(cutout.offset),
    };
  }

  static DeviceSpeaker deserializeSpeaker(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return DeviceSpeaker(
      color: deserializeColor(data['color']),
      size: deserializeSize(data['size']),
      radius: deserializeRadius(data['radius']),
      offset: deserializeOffset(data['offset']),
    );
  }

  static Map<String, dynamic> serializeSpeaker(DeviceSpeaker speaker) {
    if (speaker == null) return null;
    return <String, dynamic>{
      'color': serializeColor(speaker.color),
      'size': serializeSize(speaker.size),
      'radius': serializeRadius(speaker.radius),
      'offset': serializeOffset(speaker.offset),
    };
  }

  static DeviceHomeButton deserializeHomeButton(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return DeviceHomeButton(
      color: deserializeColor(data['color']),
      size: deserializeSize(data['size']),
      borderRadius: deserializeBorderRadius(data['borderRadius']),
      offset: deserializeOffset(data['offset']),
      hasInnerSquare: data['hasInnerSquare'] as bool,
      innerSquareColor: deserializeColor(data['innerSquareColor']),
    );
  }

  static Map<String, dynamic> serializeHomeButton(DeviceHomeButton speaker) {
    if (speaker == null) return null;
    return <String, dynamic>{
      'color': serializeColor(speaker.color),
      'size': serializeSize(speaker.size),
      'borderRadius': serializeBorderRadius(speaker.borderRadius),
      'offset': serializeOffset(speaker.offset),
      'hasInnerSquare': speaker.hasInnerSquare,
      'innerSquareColor': serializeColor(speaker.innerSquareColor),
    };
  }

  static DeviceStatusBar deserializeStatusBar(dynamic data) {
    if (data == null) return null;
    if (data is! Map<String, dynamic>) return null;
    return DeviceStatusBar(
      color: deserializeColor(data['color']),
    );
  }

  static Map<String, dynamic> serializeStatusBar(DeviceStatusBar battery) {
    if (battery == null) return null;
    return <String, dynamic>{
      'color': serializeColor(battery.color),
    };
  }

  static Color deserializeColor(dynamic data) {
    if (data == null) return null;
    return Color((data as num).toInt());
  }

  static int serializeColor(Color color) {
    if (color == null) return null;
    return color.value;
  }

  static DeviceEdge deserializeEdge(dynamic data) {
    if (data == null) return null;
    return DeviceEdge.values.firstWhere((value) => value.toString() == data, orElse: () => null);
  }

  static String serializeEdge(DeviceEdge edge) {
    if (edge == null) return null;
    return edge.toString();
  }

  static DeviceAlignment deserializeAlignment(dynamic data) {
    if (data == null) return null;
    return DeviceAlignment.values.firstWhere((value) => value.toString() == data, orElse: () => null);
  }

  static String serializeAlignment(DeviceAlignment alignment) {
    if (alignment == null) return null;
    return alignment.toString();
  }

  static DeviceBatteryLevel deserializeBatteryLevel(dynamic data) {
    if (data == null) return null;
    return DeviceBatteryLevel.values.firstWhere((value) => value.toString() == data, orElse: () => null);
  }

  static String serializeBatteryLevel(DeviceBatteryLevel level) {
    if (level == null) return null;
    return level.toString();
  }

  static DeviceSignalStrength deserializeSignalStrength(dynamic data) {
    if (data == null) return null;
    return DeviceSignalStrength.values.firstWhere((value) => value.toString() == data, orElse: () => null);
  }

  static String serializeSignalStrength(DeviceSignalStrength strength) {
    if (strength == null) return null;
    return strength.toString();
  }

  static DeviceWifiStrength deserializeWifiStrength(dynamic data) {
    if (data == null) return null;
    return DeviceWifiStrength.values.firstWhere((value) => value.toString() == data, orElse: () => null);
  }

  static String serializeWifiStrength(DeviceWifiStrength strength) {
    if (strength == null) return null;
    return strength.toString();
  }

  static TargetPlatform deserializePlatform(dynamic data) {
    if (data == null) return null;
    return TargetPlatform.values.firstWhere((value) => value.toString() == data, orElse: () => null);
  }

  static String serializePlatform(TargetPlatform platform) {
    if (platform == null) return null;
    return platform.toString();
  }
}
