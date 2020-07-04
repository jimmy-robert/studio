import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../app/app_controller.dart';
import '../../../provider/provider.dart';
import '../../studio_controller.dart';

class RerunTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(MdiIcons.restartAlert),
      title: Text('Rerun'),
      subtitle: Text('Hard reboot app from the start'),
      onTap: () {
        final appContext = context.get<StudioController>().appContext;
        final controller = appContext.get<AppController>();
        controller.rerun();
      },
    );
  }
}
