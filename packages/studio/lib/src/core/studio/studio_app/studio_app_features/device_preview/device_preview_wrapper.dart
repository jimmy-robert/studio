import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../provider/provider.dart';
import '../../../../reactive/actions.dart';
import '../../../../reactive/observer.dart';
import 'device_preview_controller.dart';
import 'widgets/device_frame.dart';

class DevicePreviewWrapper extends StatelessWidget {
  final Widget child;
  const DevicePreviewWrapper({@required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = context.get<DevicePreviewController>();

    return Observer(builder: (context) {
      if (!controller.enabled.value) return child;

      Widget device = DeviceFrame(
        orientation: controller.orientation.value,
        device: controller.device.value,
        child: child,
        isKeyboardVisible: controller.isKeyboardVisible.value,
      );

      if (!controller.fullscreen.value) device = Center(child: device);

      return ClipRect(
        child: Container(
          color: Color(0xFFE1E3E6),
          child: Stack(
            children: [
              Positioned(left: 88, right: 0, top: 0, bottom: 0, child: device),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      floatingActionButtonTheme: FloatingActionButtonThemeData(
                        elevation: 1,
                        disabledElevation: 1,
                        focusElevation: 1,
                        hoverElevation: 1,
                        highlightElevation: 1,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.grey.shade800,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            runInAction(() {
                              if (controller.orientation.value == Orientation.portrait) {
                                controller.orientation.value = Orientation.landscape;
                              } else {
                                controller.orientation.value = Orientation.portrait;
                              }
                            });
                          },
                          child: controller.orientation.value == Orientation.portrait
                              ? Icon(MdiIcons.phoneRotateLandscape)
                              : Icon(MdiIcons.phoneRotatePortrait),
                        ),
                        const SizedBox(height: 16),
                        FloatingActionButton(
                          onPressed: () {
                            runInAction(() => controller.isKeyboardVisible.value = !controller.isKeyboardVisible.value);
                          },
                          child: Icon(MdiIcons.keyboard),
                        ),
                        const SizedBox(height: 16),
                        FloatingActionButton(
                          onPressed: () {
                            runInAction(() => controller.fullscreen.value = !controller.fullscreen.value);
                          },
                          child:
                              controller.fullscreen.value ? Icon(MdiIcons.fullscreenExit) : Icon(MdiIcons.fullscreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
