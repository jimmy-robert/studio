import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../../utils/navigator.dart';
import '../../../../../../utils/number.dart';
import '../../../../../../widgets/separated_list.dart';
import '../../../../../../widgets/value_selector.dart';
import '../../../../../provider/provider.dart';
import '../../../../../reactive/actions.dart';
import '../../../../../reactive/observer.dart';
import '../device_preview_controller.dart';
import 'device_body_screen.dart';
import 'device_grid.dart';
import 'device_insets_screen.dart';
import 'device_navigation_bar_screen.dart';
import 'device_pixel_ratio_screen.dart';
import 'device_size_screen.dart';

class DeviceDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = context.get<DevicePreviewController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Device preview'),
      ),
      body: Observer(
        builder: (context) {
          final enabled = controller.enabled.value;
          final device = controller.device.value;
          return SeparatedList(
            children: [
              SwitchListTile(
                title: Text('Enabled'),
                value: enabled,
                onChanged: (value) => runInAction(() => controller.enabled.value = value),
              ),
              Container(
                height: 24,
                color: Colors.white.withOpacity(0.015),
              ),
              ListTile(
                enabled: enabled,
                title: Text('Select a device'),
                leading: Icon(MdiIcons.tabletCellphone),
                onTap: () {
                  final route = MaterialPageRoute<void>(builder: (context) => DeviceGrid());
                  Navigator.of(context).push(route);
                },
              ),
              Container(
                height: 24,
                color: Colors.white.withOpacity(0.015),
              ),
              ListTile(
                enabled: enabled,
                title: Text('Platform'),
                leading: () {
                  switch (device.platform) {
                    case TargetPlatform.android:
                      return Icon(MdiIcons.android);
                    case TargetPlatform.fuchsia:
                      return Icon(MdiIcons.cellphone);
                    case TargetPlatform.iOS:
                      return Icon(MdiIcons.apple);
                    case TargetPlatform.linux:
                      return Icon(MdiIcons.linux);
                    case TargetPlatform.macOS:
                      return Icon(MdiIcons.appleKeyboardCommand);
                    case TargetPlatform.windows:
                      return Icon(MdiIcons.microsoftWindows);
                    default:
                      return Icon(MdiIcons.cellphone);
                  }
                }(),
                subtitle: () {
                  switch (device.platform) {
                    case TargetPlatform.android:
                      return Text('Android');
                    case TargetPlatform.fuchsia:
                      return Text('Fuchsia');
                    case TargetPlatform.iOS:
                      return Text('iOS');
                    case TargetPlatform.linux:
                      return Text('Linux');
                    case TargetPlatform.macOS:
                      return Text('macOS');
                    case TargetPlatform.windows:
                      return Text('Windows');
                    default:
                      return Text('-');
                  }
                }(),
                onTap: () async {
                  final route = MaterialPageRoute<TargetPlatform>(builder: (context) {
                    return ValueSelector<TargetPlatform>(
                      title: 'Platform',
                      items: [
                        ValueSelectorItem('Android', TargetPlatform.android),
                        ValueSelectorItem('iOS', TargetPlatform.iOS),
                        ValueSelectorItem('Fuschia', TargetPlatform.fuchsia),
                        ValueSelectorItem('macOS', TargetPlatform.macOS),
                        ValueSelectorItem('Windows', TargetPlatform.windows),
                        ValueSelectorItem('Linux', TargetPlatform.linux),
                      ],
                    );
                  });

                  final result = await Navigator.of(context).push(route);
                  if (result != null) {
                    runInAction(() => controller.device.value = device.copyWith(platform: result));
                  }
                },
              ),
              ListTile(
                enabled: enabled,
                leading: Icon(MdiIcons.cellphoneScreenshot),
                title: Text('Size'),
                subtitle: Text('${device.size.width.short} x ${device.size.height.short}'),
                onTap: () {
                  Navigator.of(context).pushWidget<void>(builder: (context) {
                    return DeviceDataSizeScreen();
                  });
                },
              ),
              ListTile(
                enabled: enabled,
                leading: Icon(MdiIcons.relativeScale),
                title: Text('Device pixel ratio'),
                subtitle: Text('@${device.devicePixelRatio.short}x'),
                onTap: () {
                  Navigator.of(context).pushWidget<void>(builder: (context) {
                    return DevicePixelRatioScreen();
                  });
                },
              ),
              Container(
                height: 24,
                color: Colors.white.withOpacity(0.015),
              ),
              ListTile(
                enabled: enabled,
                title: Text('Insets'),
                subtitle: Text('Used for SafeAreas'),
                onTap: () {
                  Navigator.of(context).pushWidget<void>(builder: (context) {
                    return DeviceInsetsScreen();
                  });
                },
              ),
              ListTile(
                enabled: enabled,
                title: Text('Navigation bar'),
                onTap: () {
                  Navigator.of(context).pushWidget<void>(builder: (context) {
                    return DeviceNavigationBarScreen();
                  });
                },
              ),
              Container(
                height: 24,
                color: Colors.white.withOpacity(0.015),
              ),
              ListTile(
                enabled: enabled,
                title: Text('Body'),
                onTap: () {
                  Navigator.of(context).pushWidget<void>(builder: (context) {
                    return DeviceBodyScreen();
                  });
                },
              ),
              ListTile(
                enabled: enabled,
                title: Text('Battery'),
                onTap: () {},
              ),
              ListTile(
                enabled: enabled,
                title: Text('Clock'),
                onTap: () {},
              ),
              ListTile(
                enabled: enabled,
                title: Text('Status bar'),
                onTap: () {},
              ),
              ListTile(
                enabled: enabled,
                title: Text('Home bar'),
                onTap: () {},
              ),
              ListTile(
                enabled: enabled,
                title: Text('Speaker'),
                onTap: () {},
              ),
              ListTile(
                enabled: enabled,
                title: Text('Home button'),
                onTap: () {},
              ),
              ListTile(
                enabled: enabled,
                title: Text('Signal'),
                onTap: () {},
              ),
              ListTile(
                enabled: enabled,
                title: Text('Wifi'),
                onTap: () {},
              ),
            ],
          );
        },
      ),
    );
  }
}
