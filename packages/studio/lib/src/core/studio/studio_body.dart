import 'package:flutter/material.dart';

import '../provider/provider.dart';
import '../reactive/observer.dart';
import 'studio_app/studio_app.dart';
import 'studio_controller.dart';
import 'studio_screens/studio_screens.dart';
import 'studio_storyboards/studio_storyboards.dart';

class StudioBody extends StatelessWidget {
  final Widget app;

  const StudioBody({@required this.app});

  @override
  Widget build(BuildContext context) {
    final controller = context.get<StudioController>();
    return Observer(
      builder: (context) {
        return IndexedStack(
          index: controller.selectedIndex,
          children: [
            StudioApp(app: app),
            StudioStoryboards(),
            StudioScreens(),
          ],
        );
      },
    );
  }
}
