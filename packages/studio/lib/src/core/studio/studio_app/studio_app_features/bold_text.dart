import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../widgets/tile_switch.dart';
import '../../../provider/provider.dart';
import '../../../reactive/observer.dart';

class BoldTextController {
  final enabled = Observable(false);
}

class BoldTextTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = context.get<BoldTextController>();
    return ListTile(
      leading: Icon(Icons.format_bold),
      title: Text('Bold texts'),
      trailing: Observer(() {
        return TileSwitch(
          value: controller.enabled.value,
          onChanged: (value) {
            runInAction(() => controller.enabled.value = value);
          },
        );
      }),
    );
  }
}

class BoldTextWrapper extends StatelessWidget {
  final Widget child;

  const BoldTextWrapper({@required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = context.get<BoldTextController>();
    return Observer(() {
      if (!controller.enabled.value) return child;

      return MediaQuery(
        data: MediaQuery.of(context).copyWith(boldText: true),
        child: child,
      );
    });
  }
}
