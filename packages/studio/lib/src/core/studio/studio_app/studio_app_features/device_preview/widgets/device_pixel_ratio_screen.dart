import 'package:flutter/material.dart';
import 'package:studio/src/core/studio/studio_app/studio_app_features/device_preview/device_preview_controller.dart';
import 'package:studio/src/utils/number.dart';
import 'package:studio/src/widgets/separated_list.dart';
import 'package:studio/studio.dart';

class DevicePixelRatioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = context.get<DevicePreviewController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Device pixel ratio'),
      ),
      body: SeparatedList(
        children: [
          ListTile(
            title: Text('Device pixel ratio'),
            subtitle: Observer(
              builder: (context) => Text('@${controller.device.value.devicePixelRatio.short}x'),
            ),
          ),
          Container(
            height: 24,
            color: Colors.white.withOpacity(0.015),
          ),
          Observer(
            builder: (context) {
              return Slider(
                min: 0.5,
                max: 5,
                divisions: 9,
                value: controller.device.value.devicePixelRatio,
                onChanged: (value) {
                  runInAction(() {
                    controller.device.value = controller.device.value.copyWith(
                      devicePixelRatio: (value * 10).round() / 10,
                    );
                  });
                },
              );
            },
          ),
          Container(
            height: 24,
            color: Colors.white.withOpacity(0.015),
          ),
          _DevicePixelRatioTile(devicePixelRatio: 1),
          _DevicePixelRatioTile(devicePixelRatio: 2),
          _DevicePixelRatioTile(devicePixelRatio: 3),
          _DevicePixelRatioTile(devicePixelRatio: 4),
          _DevicePixelRatioTile(devicePixelRatio: 5),
        ],
      ),
    );
  }
}

class _DevicePixelRatioTile extends StatelessWidget {
  final int devicePixelRatio;

  const _DevicePixelRatioTile({this.devicePixelRatio});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('@${devicePixelRatio}x'),
      onTap: () {
        runInAction(() {
          final controller = context.get<DevicePreviewController>();
          controller.device.value = controller.device.value.copyWith(devicePixelRatio: devicePixelRatio.toDouble());
        });
      },
    );
  }
}
