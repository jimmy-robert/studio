import 'package:flutter/material.dart';

import '../../../../provider/provider.dart';
import '../../../../reactive/observer.dart';
import 'device_preview_controller.dart';

class DevicePreviewAppWrapper extends StatelessWidget {
  final Widget child;
  const DevicePreviewAppWrapper({@required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = context.get<DevicePreviewController>();

    return Observer(
      builder: (context) {
        if (!controller.enabled.value) return child;

        final device = controller.device.value;
        final portrait = controller.orientation.value == Orientation.portrait;

        final padding = portrait ? device.insets.portrait : device.insets.landscape;

        final viewInsets = controller.isKeyboardVisible.value
            ? EdgeInsets.only(bottom: device.keyboard.height + padding.bottom)
            : EdgeInsets.zero;

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            size: portrait ? device.size : device.size.flipped,
            padding: padding,
            devicePixelRatio: device.devicePixelRatio,
            viewInsets: viewInsets,
          ),
          child: Theme(
            data: Theme.of(context).copyWith(platform: device.platform),
            child: child,
          ),
        );
      },
    );
  }
}
