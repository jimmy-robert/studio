import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:studio/src/core/studio/studio_app/studio_app_features/device_preview/widgets/device_value_editor.dart';

import '../../../../../../../studio.dart';
import '../../../../../../utils/number.dart';
import '../../../../../../widgets/separated_list.dart';
import '../../../../../provider/provider.dart';
import '../device_preview_controller.dart';

class DeviceDataSizeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = context.get<DevicePreviewController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Device size'),
      ),
      body: Observer(
        builder: (context) {
          final data = controller.device.value;
          return SeparatedList(
            children: [
              DeviceValueEditor(
                title: 'Width',
                icon: MdiIcons.arrowLeftRight,
                value: data.size.width,
                minValue: 100,
                maxValue: 1400,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = data.copyWith(
                      size: Size(value, data.size.height),
                    );
                  });
                },
              ),
              DeviceValueEditor(
                title: 'Height',
                icon: MdiIcons.arrowUpDown,
                value: data.size.height,
                minValue: 100,
                maxValue: 1400,
                onValueChanged: (value) {
                  runInAction(() {
                    controller.device.value = data.copyWith(
                      size: Size(data.size.width, value),
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
