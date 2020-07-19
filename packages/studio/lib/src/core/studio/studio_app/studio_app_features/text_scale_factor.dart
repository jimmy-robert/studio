import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobx/mobx.dart';

import '../../../../widgets/separated_list.dart';
import '../../../../widgets/tile_switch.dart';
import '../../../provider/provider.dart';
import '../../../reactive/observer.dart';

class TextScaleFactorController {
  final textScaleFactor = Observable(1.0);
  final enabled = Observable(false);
}

class TextScaleFactorTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = context.get<TextScaleFactorController>();
    return ListTile(
      leading: Icon(MdiIcons.formatSize),
      title: Text('Text scale factor'),
      subtitle: Observer(
        builder: (context) {
          final textScaleFactor = controller.textScaleFactor.value;
          final value = textScaleFactor % 1 == 0 ? textScaleFactor.round() : textScaleFactor;
          return Text('${value}x');
        },
      ),
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
        final route = MaterialPageRoute<void>(
          builder: (context) {
            return TextScaleFactorScreen();
          },
        );
        Navigator.of(context).push(route);
      },
    );
  }
}

class TextScaleFactorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = context.get<TextScaleFactorController>();
    return Scaffold(
      appBar: AppBar(title: Text('Text scale factor')),
      body: SeparatedList(
        children: [
          Observer(
            builder: (context) {
              final value = controller.textScaleFactor.value;
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: value,
                ),
                child: Container(
                  height: 240,
                  color: Colors.black38,
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0xFF36414F),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.format_size),
                        title: Text('This is a preview'),
                        subtitle: Text('${value % 1 == 0 ? value.round() : value}x'),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Observer(
              builder: (context) {
                return Slider(
                  divisions: 10,
                  value: controller.textScaleFactor.value,
                  min: 0.5,
                  max: 3,
                  activeColor: Colors.teal,
                  label: '${controller.textScaleFactor.value}x',
                  onChanged: (value) {
                    runInAction(() => controller.textScaleFactor.value = (value * 100).round() / 100);
                  },
                );
              },
            ),
          ),
          ListTile(
            title: Text('Small'),
            subtitle: Text('0.75x'),
            onTap: () => runInAction(() => controller.textScaleFactor.value = 0.75),
          ),
          ListTile(
            title: Text('Default'),
            subtitle: Text('1x'),
            onTap: () => runInAction(() => controller.textScaleFactor.value = 1),
          ),
          ListTile(
            title: Text('Large'),
            subtitle: Text('1.5x'),
            onTap: () => runInAction(() => controller.textScaleFactor.value = 1.5),
          ),
          ListTile(
            title: Text('Huge'),
            subtitle: Text('2x'),
            onTap: () => runInAction(() => controller.textScaleFactor.value = 2),
          ),
        ],
      ),
    );
  }
}

class TextScaleFactorWrapper extends StatelessWidget {
  final Widget child;
  const TextScaleFactorWrapper({@required this.child});
  @override
  Widget build(BuildContext context) {
    final controller = context.get<TextScaleFactorController>();
    return Observer(
      builder: (context) {
        final enabled = controller.enabled.value;
        if (!enabled) return child;

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: controller.textScaleFactor.value),
          child: child,
        );
      },
    );
  }
}
