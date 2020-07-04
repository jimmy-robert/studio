import 'package:flutter/material.dart';

import '../provider/provider.dart';
import '../reactive/observer.dart';
import 'studio_app.dart';
import 'studio_controller.dart';

class StudioBody extends StatelessWidget {
  final Widget app;

  const StudioBody({@required this.app});

  @override
  Widget build(BuildContext context) {
    final controller = context.get<StudioController>();
    return Observer(() {
      return IndexedStack(
        index: controller.selectedIndex,
        children: [
          StudioApp(app: app),
          Container(color: Colors.red), // todo Storyboards
          Container(color: Colors.blue), // todo Screens
        ],
      );
    });
  }
}
