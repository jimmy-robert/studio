import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../data/device.dart';
import '../data/device_alignment.dart';
import '../data/device_battery_level.dart';
import '../data/device_edge.dart';
import '../data/device_side_button.dart';
import '../data/device_signal_strength.dart';
import '../data/device_wifi_strength.dart';
import 'device_keyboard_widget.dart';

// Code highly inspired by device_preview and device_frame by Aloïs Deniel
// https://github.com/aloisdeniel/flutter_device_preview
// It just adds som simple features (clock, signal, wifi, home bar, ...)

class DeviceFrame extends StatelessWidget {
  final Device device;
  final Widget child;
  final Orientation orientation;
  final bool isKeyboardVisible;
  final Duration keyboardTransitionDuration;

  DeviceFrame({
    @required this.device,
    @required this.child,
    this.orientation = Orientation.portrait,
    this.isKeyboardVisible = false,
    this.keyboardTransitionDuration = const Duration(milliseconds: 250),
  })  : assert(device != null),
        assert(isKeyboardVisible != null);

  @override
  Widget build(BuildContext context) {
    var padding = device.body.insets;

    final portrait = orientation == Orientation.portrait;

    if (!portrait) {
      padding = EdgeInsets.only(
        left: padding.bottom,
        top: padding.right,
        right: padding.top,
        bottom: padding.left,
      );
    }

    final size = portrait ? device.size : device.size.flipped;

    final childWithKeyboard = Stack(
      children: <Widget>[
        Positioned.fill(
          child: child,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: AnimatedCrossFade(
            firstChild: SizedBox(),
            secondChild: DeviceKeyboardWidget(
              keyboard: device.keyboard,
            ),
            crossFadeState: isKeyboardVisible ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: keyboardTransitionDuration,
          ),
        ),
      ],
    );

    final sizedChild = SizedBox(
      width: size.width,
      height: size.height - (device.navigationBar?.height ?? 0),
      child: childWithKeyboard,
    );

    return FittedBox(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(device.body.edgeRadius),
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 70,
                      color: Color(0x50000000),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: padding,
              child: Padding(
                padding: EdgeInsets.only(bottom: device.navigationBar?.height ?? 0),
                child: sizedChild,
              ),
            ),
            if (device.navigationBar != null)
              Positioned(
                bottom: portrait ? device.body.insets.bottom : device.body.insets.right,
                left: padding.left,
                right: padding.right,
                height: device.navigationBar.height,
                child: Container(
                  color: device.navigationBar.color,
                  child: IconTheme(
                    data: IconThemeData(
                      color: device.navigationBar.iconsColor,
                      size: device.navigationBar.iconsSize,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: RotatedBox(quarterTurns: 3, child: Icon(MdiIcons.triangle)),
                          ),
                        ),
                        Expanded(child: Center(child: Icon(MdiIcons.circle))),
                        Expanded(child: Center(child: Icon(MdiIcons.square))),
                      ],
                    ),
                  ),
                ),
              ),
            if (device.homeBar != null)
              Positioned(
                bottom: device.body.insets.bottom + 8,
                left: padding.left,
                right: padding.right,
                height: device.homeBar.size.height,
                child: Center(
                  child: Container(
                    width: device.homeBar.size.width,
                    decoration: BoxDecoration(
                      color: device.homeBar.color,
                      borderRadius: BorderRadius.circular(device.homeBar.size.height / 2),
                    ),
                  ),
                ),
              ),
            if (device.statusBar != null)
              Positioned(
                top: padding.top,
                left: padding.left,
                right: padding.right,
                height: portrait ? device.insets.portrait.top : device.insets.landscape.top,
                child: Container(color: device.statusBar.color),
              ),
            if (device.clock != null)
              Positioned(
                top: padding.top,
                left: padding.left,
                right: padding.right,
                height: portrait ? device.insets.portrait.top : device.insets.landscape.top,
                child: ClipRect(
                  child: Container(
                    alignment: device.clock.align.asAlign,
                    transform: Matrix4.translationValues(device.clock.offset.dx, device.clock.offset.dy, 0),
                    child: Text(
                      device.clock.time,
                      style: TextStyle(
                        fontSize: device.clock.fontSize,
                        color: device.clock.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            if (device.battery != null)
              Positioned(
                top: padding.top,
                left: padding.left,
                right: padding.right,
                height: portrait ? device.insets.portrait.top : device.insets.landscape.top,
                child: ClipRect(
                  child: Container(
                    alignment: device.battery.align.asAlign,
                    transform: Matrix4.translationValues(device.battery.offset.dx, device.battery.offset.dy, 0),
                    child: RotatedBox(
                      quarterTurns: device.battery.rotation,
                      child: Icon(
                        () {
                          switch (device.battery.level) {
                            case DeviceBatteryLevel.battery0:
                              return MdiIcons.batteryOutline;
                            case DeviceBatteryLevel.battery10:
                              return MdiIcons.battery10;
                            case DeviceBatteryLevel.battery20:
                              return MdiIcons.battery20;
                            case DeviceBatteryLevel.battery30:
                              return MdiIcons.battery30;
                            case DeviceBatteryLevel.battery40:
                              return MdiIcons.battery40;
                            case DeviceBatteryLevel.battery50:
                              return MdiIcons.battery50;
                            case DeviceBatteryLevel.battery60:
                              return MdiIcons.battery60;
                            case DeviceBatteryLevel.battery70:
                              return MdiIcons.battery70;
                            case DeviceBatteryLevel.battery80:
                              return MdiIcons.battery80;
                            case DeviceBatteryLevel.battery90:
                              return MdiIcons.battery90;
                            case DeviceBatteryLevel.battery100:
                              return MdiIcons.battery;
                          }
                        }(),
                        size: device.battery.size,
                        color: device.battery.color,
                      ),
                    ),
                  ),
                ),
              ),
            if (device.signal != null)
              Positioned(
                top: padding.top,
                left: padding.left,
                right: padding.right,
                height: portrait ? device.insets.portrait.top : device.insets.landscape.top,
                child: ClipRect(
                  child: Container(
                    alignment: device.signal.align.asAlign,
                    transform: Matrix4.translationValues(device.signal.offset.dx, device.signal.offset.dy, 0),
                    child: Icon(
                      () {
                        switch (device.signal.strength) {
                          case DeviceSignalStrength.signal0:
                            return MdiIcons.networkStrengthOutline;
                          case DeviceSignalStrength.signal1:
                            return MdiIcons.networkStrength1;
                          case DeviceSignalStrength.signal2:
                            return MdiIcons.networkStrength2;
                          case DeviceSignalStrength.signal3:
                            return MdiIcons.networkStrength3;
                          case DeviceSignalStrength.signal4:
                            return MdiIcons.networkStrength4;
                        }
                      }(),
                      size: device.signal.size,
                      color: device.signal.color,
                    ),
                  ),
                ),
              ),
            if (device.wifi != null)
              Positioned(
                top: padding.top,
                left: padding.left,
                right: padding.right,
                height: portrait ? device.insets.portrait.top : device.insets.landscape.top,
                child: ClipRect(
                  child: Container(
                    alignment: device.wifi.align.asAlign,
                    transform: Matrix4.translationValues(device.wifi.offset.dx, device.wifi.offset.dy, 0),
                    child: Icon(
                      () {
                        switch (device.wifi.strength) {
                          case DeviceWifiStrength.wifi0:
                            return MdiIcons.wifiStrengthOutline;
                          case DeviceWifiStrength.wifi1:
                            return MdiIcons.wifiStrength1;
                          case DeviceWifiStrength.wifi2:
                            return MdiIcons.wifiStrength1;
                          case DeviceWifiStrength.wifi3:
                            return MdiIcons.wifiStrength1;
                          case DeviceWifiStrength.wifi4:
                            return MdiIcons.wifiStrength1;
                        }
                      }(),
                      size: device.wifi.size,
                      color: device.wifi.color,
                    ),
                  ),
                ),
              ),
            if (device.cutout != null)
              Positioned(
                top: padding.top,
                left: padding.left,
                right: padding.right,
                bottom: padding.bottom,
                child: Align(
                  alignment: () {
                    final align = device.cutout.align.asAlign;
                    if (portrait) return align;
                    return Alignment(-align.y, align.x);
                  }(),
                  child: Container(
                    width: portrait ? device.cutout.size.width : device.cutout.size.height,
                    height: portrait ? device.cutout.size.height : device.cutout.size.width,
                    transform: Matrix4.translationValues(
                      portrait ? device.cutout.offset.dx : -device.cutout.offset.dy,
                      portrait ? device.cutout.offset.dy : device.cutout.offset.dx,
                      0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(device.cutout.radius),
                    ),
                  ),
                ),
              ),
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _DeviceFramePainter(
                    deviceFrame: this,
                  ),
                ),
              ),
            ),
            if (device.homeButton != null)
              Positioned(
                bottom: 0,
                width: portrait ? null : device.body.insets.bottom,
                height: portrait ? device.body.insets.bottom : null,
                left: 0,
                top: portrait ? null : 0,
                right: portrait ? 0 : null,
                child: Center(
                  child: Container(
                    width: portrait ? device.homeButton.size.width : device.homeButton.size.height,
                    height: portrait ? device.homeButton.size.height : device.homeButton.size.width,
                    alignment: Alignment.center,
                    transform: Matrix4.translationValues(
                      portrait ? device.homeButton.offset.dx : -device.homeButton.offset.dy,
                      portrait ? device.homeButton.offset.dy : device.homeButton.offset.dx,
                      0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade800, width: 1),
                      borderRadius: portrait
                          ? device.homeButton.borderRadius
                          : BorderRadius.only(
                              topLeft: device.homeButton.borderRadius.bottomLeft,
                              topRight: device.homeButton.borderRadius.topLeft,
                              bottomRight: device.homeButton.borderRadius.topRight,
                              bottomLeft: device.homeButton.borderRadius.bottomRight,
                            ),
                    ),
                    child: !device.homeButton.hasInnerSquare
                        ? null
                        : Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              border: Border.all(color: device.homeButton.innerSquareColor, width: 2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                  ),
                ),
              ),
            if (device.speaker != null)
              Positioned(
                top: 0,
                bottom: portrait ? null : 0,
                height: portrait ? device.body.insets.top : null,
                width: portrait ? null : device.body.insets.top,
                left: portrait ? 0 : null,
                right: 0,
                child: Center(
                  child: Container(
                    width: portrait ? device.speaker.size.width : device.speaker.size.height,
                    height: portrait ? device.speaker.size.height : device.speaker.size.width,
                    transform: Matrix4.translationValues(
                      portrait ? device.speaker.offset.dx : -device.speaker.offset.dy,
                      portrait ? device.speaker.offset.dy : device.speaker.offset.dx,
                      0,
                    ),
                    decoration: BoxDecoration(
                      color: device.speaker.color,
                      borderRadius: BorderRadius.all(device.speaker.radius),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DeviceFramePainter extends CustomPainter {
  final DeviceFrame deviceFrame;

  const _DeviceFramePainter({
    @required this.deviceFrame,
  });

  Path _createBodyPath(Size size) {
    final radius = deviceFrame.device.body.edgeRadius;
    return Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Offset.zero & size,
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
      );
  }

  Path _createScreenPath(Size size) {
    final radius = deviceFrame.device.body.screenRadius;
    final insets = deviceFrame.device.body.insets;
    return Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Offset(insets.left, insets.top) &
              Size(size.width - insets.left - insets.right, size.height - insets.top - insets.bottom),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
      );
  }

  Path _createButtonPath(DeviceSideButton button, Rect bodyBounds) {
    final buttonPath = Path();
    switch (button.edge) {
      case DeviceEdge.left:
        final left = bodyBounds.left - button.size.height;
        final top = bodyBounds.top + button.offset.dy;
        final rect = Rect.fromLTWH(
          left,
          top,
          button.size.height,
          button.size.width,
        );
        buttonPath.addRRect(
          RRect.fromRectAndCorners(
            rect,
            topLeft: button.radius,
            bottomLeft: button.radius,
          ),
        );
        break;
      case DeviceEdge.right:
        final left = bodyBounds.right;
        final top = bodyBounds.top + button.offset.dy;
        final rect = Rect.fromLTWH(
          left,
          top,
          button.size.height,
          button.size.width,
        );
        buttonPath.addRRect(
          RRect.fromRectAndCorners(
            rect,
            topRight: button.radius,
            bottomRight: button.radius,
          ),
        );
        break;
      case DeviceEdge.top:
        final left = bodyBounds.left + button.offset.dx;
        final top = bodyBounds.top - button.size.height;
        final rect = Rect.fromLTWH(
          left,
          top,
          button.size.width,
          button.size.height,
        );
        buttonPath.addRRect(
          RRect.fromRectAndCorners(
            rect,
            topLeft: button.radius,
            topRight: button.radius,
          ),
        );
        break;
      case DeviceEdge.bottom:
        final left = bodyBounds.left + button.offset.dx;
        final top = bodyBounds.bottom;
        final rect = Rect.fromLTWH(
          left,
          top,
          button.size.width,
          button.size.height,
        );
        buttonPath.addRRect(
          RRect.fromRectAndCorners(
            rect,
            bottomLeft: button.radius,
            bottomRight: button.radius,
          ),
        );
        break;
      default:
        break;
    }

    return buttonPath;
  }

  Path _createNotchPath(Size size) {
    final offset = Offset(
      (size.width / 2) - (deviceFrame.device.notch.size.width / 2),
      deviceFrame.device.body.insets.top - 1,
    );
    final notchRect = offset & Size(deviceFrame.device.notch.size.width, deviceFrame.device.notch.size.height + 1);

    final joinRadius = deviceFrame.device.notch.joinRadius;
    final leftCornerMiniRect = Offset(notchRect.left - joinRadius.x, notchRect.top) &
        Size(
          joinRadius.x,
          joinRadius.x,
        );
    final leftCorner = Path.combine(
      PathOperation.difference,
      Path() //
        ..addRect(leftCornerMiniRect),
      Path()
        ..addRRect(
          RRect.fromRectAndCorners(
            leftCornerMiniRect,
            topRight: Radius.circular(joinRadius.x / 2),
          ),
        ),
    );

    final rightCornerMiniRect = Offset(notchRect.right, notchRect.top) & Size(joinRadius.x, joinRadius.x);
    final rightCorner = Path.combine(
      PathOperation.difference,
      Path() //
        ..addRect(rightCornerMiniRect),
      Path()
        ..addRRect(
          RRect.fromRectAndCorners(
            rightCornerMiniRect,
            topLeft: Radius.circular(joinRadius.x / 2),
          ),
        ),
    );

    return Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          notchRect,
          bottomLeft: deviceFrame.device.notch.radius,
          bottomRight: deviceFrame.device.notch.radius,
        ),
      )
      ..addPath(
        leftCorner,
        Offset.zero,
      )
      ..addPath(
        rightCorner,
        Offset.zero,
      );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final insets = deviceFrame.device.body.insets;
    final size = Size(
      deviceFrame.device.size.width + insets.left + insets.right,
      deviceFrame.device.size.height + insets.top + insets.bottom,
    );

    if (deviceFrame.orientation == Orientation.landscape) {
      final transform = Matrix4.rotationZ(math.pi * 0.5) * Matrix4.translationValues(0.0, -size.height, 0.0) as Matrix4;
      canvas.transform(transform.storage);
    }

    final body = _createBodyPath(size);
    var screen = _createScreenPath(size);

    if (deviceFrame.device.notch != null && deviceFrame.device.notch.size.width > 0) {
      final notchPath = _createNotchPath(size);
      screen = Path.combine(
        PathOperation.difference,
        screen,
        notchPath,
      );
    }

    final bodyWithoutScreen = Path.combine(PathOperation.difference, body, screen);

    canvas.drawPath(
      bodyWithoutScreen,
      Paint()
        ..style = PaintingStyle.fill
        ..color = deviceFrame.device.body.color,
    );

    final bodyBounds = body.getBounds();

    deviceFrame.device.body.sideButtons.forEach((button) {
      canvas.drawPath(
        _createButtonPath(button, bodyBounds),
        Paint()
          ..style = PaintingStyle.fill
          ..color = button.color,
      );
    });

    canvas.drawPath(
      body,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = deviceFrame.device.body.borderSize
        ..color = deviceFrame.device.body.borderColor,
    );
  }

  @override
  bool shouldRepaint(_DeviceFramePainter oldDelegate) => true; // todo

  @override
  bool shouldRebuildSemantics(_DeviceFramePainter oldDelegate) => false;
}

extension on DeviceAlignment {
  Alignment get asAlign {
    switch (this) {
      case DeviceAlignment.start:
        return Alignment.centerLeft;
      case DeviceAlignment.center:
        return Alignment.center;
      case DeviceAlignment.end:
        return Alignment.centerRight;
      default:
        throw Exception('Not supported');
    }
  }
}
