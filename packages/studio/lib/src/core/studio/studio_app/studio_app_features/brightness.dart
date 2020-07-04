import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobx/mobx.dart';

import '../../../../widgets/tile_switch.dart';
import '../../../../widgets/value_selector.dart';
import '../../../provider/provider.dart';
import '../../../reactive/observer.dart';

class BrightnessController {
  final brightness = Observable(Brightness.light);

  final enabled = Observable(false);
}

class BrightnessTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = context.get<BrightnessController>();
    return ListTile(
      leading: Icon(MdiIcons.themeLightDark),
      title: Text('Brightness'),
      subtitle: Observer(() => Text(controller.brightness.value == Brightness.light ? 'Light' : 'Dark')),
      trailing: Observer(() {
        return TileSwitch(
          value: controller.enabled.value,
          onChanged: (value) {
            runInAction(() => controller.enabled.value = value);
          },
        );
      }),
      onTap: () async {
        final route = MaterialPageRoute<Brightness>(builder: (context) {
          return ValueSelector<Brightness>(
            title: 'Brightness',
            items: [
              ValueSelectorItem('Light', Brightness.light),
              ValueSelectorItem('Dark', Brightness.dark),
            ],
          );
        });
        final value = await Navigator.of(context).push(route);
        if (value != null) runInAction(() => controller.brightness.value = value);
      },
    );
  }
}

class BrightnessWrapper extends StatelessWidget {
  final Widget child;

  const BrightnessWrapper({@required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = context.get<BrightnessController>();
    return Observer(() {
      final enabled = controller.enabled.value;
      if (!enabled) return child;

      return MediaQuery(
        data: MediaQuery.of(context).copyWith(platformBrightness: controller.brightness.value),
        child: child,
      );
    });
  }
}
