import 'package:flutter/material.dart';

import '../../../../../../../studio.dart';
import '../../../../../../widgets/separated_list.dart';
import '../../../../../reactive/observer.dart';
import '../data/device_navigation_bar.dart';
import '../device_preview_controller.dart';
import 'device_color_editor.dart';
import 'device_value_editor.dart';

class DeviceNavigationBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation bar'),
      ),
      body: Observer(
        builder: (context) {
          final controller = context.get<DevicePreviewController>();
          final device = controller.device.value;
          return SeparatedList(
            children: [
              SwitchListTile(
                title: Text('Enabled'),
                value: device.navigationBar != null,
                onChanged: (value) {
                  runInAction(() {
                    if (value) {
                      controller.device.value = device.copyWith(
                        navigationBar: const DeviceNavigationBar(),
                      );
                    } else {
                      controller.device.value = device.remove(
                        navigationBar: true,
                      );
                    }
                  });
                },
              ),
              Container(
                height: 24,
                color: Colors.white.withOpacity(0.015),
              ),
              DeviceValueEditor(
                enabled: device.navigationBar != null,
                title: 'Height',
                value: device.navigationBar?.height ?? 0,
                minValue: 0,
                maxValue: 100,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      navigationBar: DeviceNavigationBar(
                        height: value,
                        color: device.navigationBar.color,
                        iconsSize: device.navigationBar.iconsSize,
                        iconsColor: device.navigationBar.iconsColor,
                      ),
                    );
                  });
                },
              ),
              DeviceColorEditor(
                title: 'Color',
                color: device.navigationBar?.color,
                onColorChanged: (color) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      navigationBar: DeviceNavigationBar(
                        height: device.navigationBar.height,
                        color: color,
                        iconsSize: device.navigationBar.iconsSize,
                        iconsColor: device.navigationBar.iconsColor,
                      ),
                    );
                  });
                },
              ),
              Container(
                height: 24,
                color: Colors.white.withOpacity(0.015),
              ),
              DeviceValueEditor(
                enabled: device.navigationBar != null,
                title: 'Icons size',
                value: device.navigationBar?.iconsSize ?? 0,
                minValue: 0,
                maxValue: 100,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      navigationBar: DeviceNavigationBar(
                        height: device.navigationBar.height,
                        color: device.navigationBar.color,
                        iconsSize: value,
                        iconsColor: device.navigationBar.iconsColor,
                      ),
                    );
                  });
                },
              ),
              DeviceColorEditor(
                title: 'Icons color',
                color: device.navigationBar?.iconsColor,
                onColorChanged: (color) {
                  runInAction(() {
                    controller.device.value = device.copyWith(
                      navigationBar: DeviceNavigationBar(
                        height: device.navigationBar.height,
                        color: device.navigationBar.color,
                        iconsSize: device.navigationBar.iconsSize,
                        iconsColor: color,
                      ),
                    );
                  });
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
