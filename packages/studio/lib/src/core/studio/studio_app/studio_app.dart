import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../utils/duration.dart';
import '../../app/app_controller.dart';
import '../../provider/provider.dart';
import '../../reactive/actions.dart';
import '../../reactive/observer.dart';
import '../studio_controller.dart';

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

class StudioAppMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        toggleableActiveColor: Colors.blue,
        splashColor: Colors.black12,
        highlightColor: Colors.black12,
        hoverColor: Colors.black12,
        scaffoldBackgroundColor: Color(0xFF36414F),
        appBarTheme: AppBarTheme(
          color: Color(0xFF303a47),
          centerTitle: false,
          elevation: 2,
        ),
      ),
      home: Builder(
        builder: (context) {
          return Scaffold(
            body: ListView(
              children: [
                ListTile(
                  leading: Icon(MdiIcons.codeBracesBox),
                  title: Text('Application commands'),
                  subtitle: Text('Developer defined commands', maxLines: 1),
                  onTap: () {},
                ),
                Divider(height: 0),
                Container(
                  height: 20,
                  color: Colors.white.withOpacity(0.05),
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(MdiIcons.restart),
                  title: Text('Restart'),
                  subtitle: Text(
                    'Softly navigate to app root',
                    maxLines: 1,
                  ),
                  onTap: () {
                    final appContext = context.get<StudioController>().appContext;
                    final controller = appContext.get<AppController>();
                    controller.restart();
                  },
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(MdiIcons.restartAlert),
                  title: Text('Rerun'),
                  subtitle: Text('Hard reboot app from the start', maxLines: 1),
                  onTap: () {
                    final appContext = context.get<StudioController>().appContext;
                    final controller = appContext.get<AppController>();
                    controller.rerun();
                  },
                ),
                Divider(height: 0),
                Container(
                  height: 20,
                  color: Colors.white.withOpacity(0.05),
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(MdiIcons.tabletCellphone),
                  title: Text('Device preview'),
                  subtitle: Text('iPhone 11 Pro Max'),
                  trailing: Builder(
                    builder: (context) {
                      var selected = false;
                      return InkWell(
                        excludeFromSemantics: true,
                        canRequestFocus: false,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {},
                        child: StatefulBuilder(
                          builder: (context, setState) => Switch(
                            value: selected,
                            onChanged: (value) {
                              setState(() => selected = value);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  onTap: () {},
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(MdiIcons.formatSize),
                  title: Text('Text scale factor'),
                  subtitle: Text('1x'),
                  trailing: Builder(
                    builder: (context) {
                      var selected = false;
                      return InkWell(
                        excludeFromSemantics: true,
                        canRequestFocus: false,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {},
                        child: StatefulBuilder(
                          builder: (context, setState) => Switch(
                            value: selected,
                            onChanged: (value) {
                              setState(() => selected = value);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  onTap: () {},
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(MdiIcons.themeLightDark),
                  title: Text('Brightness'),
                  subtitle: Text('Dark'),
                  trailing: Builder(
                    builder: (context) {
                      var selected = false;
                      return InkWell(
                        excludeFromSemantics: true,
                        canRequestFocus: false,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {},
                        child: StatefulBuilder(
                          builder: (context, setState) => Switch(
                            value: selected,
                            onChanged: (value) {
                              setState(() => selected = value);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  onTap: () {},
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(Icons.format_bold),
                  title: Text('Bold texts'),
                  trailing: Builder(
                    builder: (context) {
                      var selected = false;
                      return InkWell(
                        excludeFromSemantics: true,
                        canRequestFocus: false,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {},
                        child: StatefulBuilder(
                          builder: (context, setState) => Switch(
                            value: selected,
                            onChanged: (value) {
                              setState(() => selected = value);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  onTap: () {},
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(MdiIcons.earth),
                  title: Text('Language'),
                  subtitle: Text('en'),
                  trailing: Builder(
                    builder: (context) {
                      var selected = false;
                      return InkWell(
                        excludeFromSemantics: true,
                        canRequestFocus: false,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {},
                        child: StatefulBuilder(
                          builder: (context, setState) => Switch(
                            value: selected,
                            onChanged: (value) {
                              setState(() => selected = value);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  onTap: () {},
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(MdiIcons.clockFast),
                  title: Text('Time dilation'),
                  subtitle: Text('1x'),
                  onTap: () {},
                ),
                Divider(height: 0),
                Container(
                  height: 20,
                  color: Colors.white.withOpacity(0.05),
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Screenshot'),
                  onTap: () {},
                ),
                Divider(height: 0),
                Container(
                  height: 20,
                  color: Colors.white.withOpacity(0.05),
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(MdiIcons.fileAccount),
                  title: Text('Shared preferences'),
                  onTap: () {},
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(MdiIcons.fileTree),
                  title: Text('File explorer'),
                  onTap: () {},
                ),
                Divider(height: 0),
                Container(
                  height: 20,
                  color: Colors.white.withOpacity(0.05),
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(MdiIcons.bookOpenPageVariant),
                  title: Text('Logs'),
                  onTap: () {},
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(MdiIcons.swapVertical),
                  title: Text('Network'),
                  onTap: () {},
                ),
                Divider(height: 0),
              ],
            ),
          );
        },
      ),
    );
  }
}
