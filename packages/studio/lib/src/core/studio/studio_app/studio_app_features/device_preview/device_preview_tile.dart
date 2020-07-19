import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../core/provider/provider.dart';
import '../../../../../utils/navigator.dart';
import '../../../../../widgets/tile_switch.dart';
import '../../../../reactive/actions.dart';
import '../../../../reactive/observer.dart';
import 'device_preview_controller.dart';
import 'widgets/device_data_screen.dart';

class DevicePreviewTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = context.get<DevicePreviewController>();
    return ListTile(
      leading: Icon(MdiIcons.tabletCellphone),
      title: Text('Device preview'),
      trailing: Observer(
        builder: (context) {
          return TileSwitch(
            value: controller.enabled.value,
            onChanged: (value) {
              runInAction(() => controller.enabled.value = value);
            },
          );
        },
      ),
      onTap: () {
        Navigator.of(context).pushWidget<void>(
          builder: (_) => DeviceDataScreen(),
        );
      },
    );
  }
}
