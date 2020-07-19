import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../utils/duration.dart';
import '../../../widgets/rerun_widget.dart';
import '../../provider/provider.dart';
import '../../reactive/actions.dart';
import '../../reactive/observer.dart';
import '../studio_controller.dart';

class StudioAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      child: Row(
        children: [
          SizedBox(width: 12),
          Observer(
            builder: (context) {
              final controller = context.get<StudioController>();
              final index = controller.selectedIndex;

              if (index != 0) return Container();

              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  runInAction(() {
                    controller.animationDuration = 200.milliseconds;
                    controller.appMenuOpen = !controller.appMenuOpen;
                  });
                },
              );
            },
          ),
          Expanded(child: Container()),
          StudioAppBarButton(
            index: 0,
            title: 'App',
          ),
          SizedBox(width: 8),
          StudioAppBarButton(
            index: 1,
            title: 'Storyboards',
          ),
          SizedBox(width: 8),
          StudioAppBarButton(
            index: 2,
            title: 'Screens',
          ),
          SizedBox(width: 12),
          IconButton(
            icon: Icon(MdiIcons.restart),
            color: Colors.grey.shade800,
            onPressed: () {
              final rerunState = context.findAncestorStateOfType<RerunWidgetState>();
              rerunState?.rerun();
            },
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
            color: Colors.grey.shade800,
          ),
          SizedBox(width: 12),
        ],
      ),
    );
  }
}

class StudioAppBarButton extends StatelessWidget {
  final String title;
  final int index;

  const StudioAppBarButton({@required this.title, @required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = context.get<StudioController>();
    return Observer(
      builder: (context) {
        final currentIndex = controller.selectedIndex;
        return FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          textColor: currentIndex == index ? Colors.white : Colors.grey.shade800,
          color: currentIndex == index ? Colors.blue : Colors.transparent,
          onPressed: () {
            controller.selectedIndex = index;
          },
          child: Text(title),
        );
      },
    );
  }
}
