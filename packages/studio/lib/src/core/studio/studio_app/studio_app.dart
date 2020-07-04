import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../utils/duration.dart';
import '../../provider/provider.dart';
import '../../reactive/actions.dart';
import '../../reactive/observer.dart';
import '../studio_controller.dart';
import 'studio_app_menu.dart';

class StudioApp extends StatelessWidget {
  final Widget app;

  StudioApp({@required this.app});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF28303b),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final controller = context.get<StudioController>();
          if (controller.appMenuWidth > constraints.maxWidth - 200) {
            runInAction(() {
              controller.appMenuWidth = controller.appMenuDraggingWidth = constraints.maxWidth - 200;
            });
          }
          return Stack(
            children: [
              Observer(() {
                final controller = context.get<StudioController>();
                return AnimatedPositioned(
                  duration: controller.animationDuration,
                  top: 0,
                  left: controller.appMenuOpen ? 0 : -80,
                  bottom: 0,
                  width: controller.appMenuWidth,
                  child: Row(children: [
                    Expanded(child: StudioAppMenu()),
                    GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      onPanUpdate: (details) {
                        runInAction(() {
                          controller.animationDuration = 0.milliseconds;
                          controller.appMenuDraggingWidth = controller.appMenuDraggingWidth + details.delta.dx;
                          controller.appMenuWidth =
                              min(max(400, controller.appMenuDraggingWidth), constraints.maxWidth - 200);
                        });
                      },
                      onPanEnd: (details) {
                        controller.appMenuDraggingWidth = controller.appMenuWidth;
                      },
                      onPanCancel: () {
                        controller.appMenuDraggingWidth = controller.appMenuWidth;
                      },
                      onDoubleTap: () {
                        runInAction(() {
                          controller.animationDuration = 200.milliseconds;
                          controller.appMenuWidth = controller.appMenuDraggingWidth = 400;
                        });
                      },
                      child: Container(
                        color: Colors.black38,
                        width: 12,
                      ),
                    ),
                  ]),
                );
              }),
              Observer(() {
                final controller = context.get<StudioController>();
                final appMenuWidth = controller.appMenuWidth;
                return AnimatedPositioned(
                  duration: controller.animationDuration,
                  top: 0,
                  left: controller.appMenuOpen ? appMenuWidth : 0.0,
                  bottom: 0,
                  right: 0,
                  child: ClipRect(child: app),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
