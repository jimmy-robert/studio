import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../widgets/separated_list.dart';
import 'studio_app_features/brightness.dart';
import 'studio_app_features/rerun.dart';
import 'studio_app_features/restart.dart';
import 'studio_app_features/time_dilation.dart';

class StudioAppMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final darkTheme = ThemeData.dark();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme.copyWith(
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
        dividerTheme: darkTheme.dividerTheme.copyWith(space: 0),
      ),
      home: Builder(
        builder: (context) {
          return Scaffold(
            body: SeparatedList(
              children: [
                ListTile(
                  leading: Icon(MdiIcons.codeBracesBox),
                  title: Text('Application commands'),
                  subtitle: Text('Developer defined commands', maxLines: 1),
                  onTap: () {},
                ),
                Container(
                  height: 24,
                  color: Colors.white.withOpacity(0.015),
                ),
                RestartTile(),
                RerunTitle(),
                Container(
                  height: 24,
                  color: Colors.white.withOpacity(0.015),
                ),
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
                BrightnessTile(),
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
                TimeDilationTile(),
                Container(
                  height: 24,
                  color: Colors.white.withOpacity(0.015),
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Screenshot'),
                  onTap: () {},
                ),
                Container(
                  height: 24,
                  color: Colors.white.withOpacity(0.015),
                ),
                ListTile(
                  leading: Icon(MdiIcons.fileAccount),
                  title: Text('Shared preferences'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(MdiIcons.fileTree),
                  title: Text('File explorer'),
                  onTap: () {},
                ),
                Container(
                  height: 24,
                  color: Colors.white.withOpacity(0.015),
                ),
                ListTile(
                  leading: Icon(MdiIcons.bookOpenPageVariant),
                  title: Text('Logs'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(MdiIcons.swapVertical),
                  title: Text('Network'),
                  onTap: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
