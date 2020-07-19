import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:studio/src/core/reactive/observer.dart';
import 'package:studio/src/core/studio/studio_app/studio_app_features/device_preview/data/device_insets.dart';
import 'package:studio/src/core/studio/studio_app/studio_app_features/device_preview/device_preview_controller.dart';
import 'package:studio/studio.dart';

import '../../../../../../widgets/separated_list.dart';
import 'device_value_editor.dart';

class DeviceInsetsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insets'),
      ),
      body: Observer(
        builder: (context) {
          final controller = context.get<DevicePreviewController>();
          final insets = controller.device.value.insets;
          return SeparatedList(
            children: [
              Container(
                height: 24,
                color: Colors.white.withOpacity(0.015),
              ),
              Container(
                color: Colors.black12,
                child: ListTile(
                  leading: Icon(MdiIcons.cropPortrait),
                  title: Text('Portrait'),
                ),
              ),
              DeviceValueEditor(
                title: 'Left',
                value: insets.portrait.left,
                minValue: 0,
                maxValue: 100,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = controller.device.value.copyWith(
                      insets: DeviceInsets(
                        portrait: insets.portrait.copyWith(left: value),
                        landscape: insets.landscape,
                      ),
                    );
                  });
                },
              ),
              DeviceValueEditor(
                title: 'Top',
                value: insets.portrait.top,
                minValue: 0,
                maxValue: 100,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = controller.device.value.copyWith(
                      insets: DeviceInsets(
                        portrait: insets.portrait.copyWith(top: value),
                        landscape: insets.landscape,
                      ),
                    );
                  });
                },
              ),
              DeviceValueEditor(
                title: 'Right',
                value: insets.portrait.right,
                minValue: 0,
                maxValue: 100,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = controller.device.value.copyWith(
                      insets: DeviceInsets(
                        portrait: insets.portrait.copyWith(right: value),
                        landscape: insets.landscape,
                      ),
                    );
                  });
                },
              ),
              DeviceValueEditor(
                title: 'Bottom',
                value: insets.portrait.bottom,
                minValue: 0,
                maxValue: 100,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = controller.device.value.copyWith(
                      insets: DeviceInsets(
                        portrait: insets.portrait.copyWith(bottom: value),
                        landscape: insets.landscape,
                      ),
                    );
                  });
                },
              ),
              Container(
                height: 24,
                color: Colors.white.withOpacity(0.015),
              ),
              Container(
                color: Colors.black12,
                child: ListTile(
                  leading: Icon(MdiIcons.cropLandscape),
                  title: Text('Landscape'),
                ),
              ),
              DeviceValueEditor(
                title: 'Left',
                value: insets.landscape.left,
                minValue: 0,
                maxValue: 100,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = controller.device.value.copyWith(
                      insets: DeviceInsets(
                        portrait: insets.portrait,
                        landscape: insets.landscape.copyWith(left: value),
                      ),
                    );
                  });
                },
              ),
              DeviceValueEditor(
                title: 'Top',
                value: insets.landscape.top,
                minValue: 0,
                maxValue: 100,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = controller.device.value.copyWith(
                      insets: DeviceInsets(
                        portrait: insets.portrait,
                        landscape: insets.landscape.copyWith(top: value),
                      ),
                    );
                  });
                },
              ),
              DeviceValueEditor(
                title: 'Right',
                value: insets.landscape.right,
                minValue: 0,
                maxValue: 100,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = controller.device.value.copyWith(
                      insets: DeviceInsets(
                        portrait: insets.portrait,
                        landscape: insets.landscape.copyWith(right: value),
                      ),
                    );
                  });
                },
              ),
              DeviceValueEditor(
                title: 'Bottom',
                value: insets.landscape.bottom,
                minValue: 0,
                maxValue: 100,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = controller.device.value.copyWith(
                      insets: DeviceInsets(
                        portrait: insets.portrait,
                        landscape: insets.landscape.copyWith(bottom: value),
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
