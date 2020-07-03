import 'package:flutter/material.dart';

import '../provider/provider.dart';
import '../reactive/observer.dart';
import 'theme_mode_controller.dart';

class ThemeBuilder extends StatelessWidget {
  final ThemeData Function(ThemeData theme) light;

  final ThemeData Function(ThemeData theme) dark;

  final Widget child;

  const ThemeBuilder({this.light, this.dark, this.child});

  const ThemeBuilder.all({
    @required ThemeData Function(ThemeData theme) builder,
    @required this.child,
  })  : light = builder,
        dark = builder;

  @override
  Widget build(BuildContext context) {
    return Observer.withContext((context) {
      var mode = context.get<ThemeModeController>()?.mode?.value;

      if (mode == null || mode == ThemeMode.system) {
        final brightness = MediaQuery.platformBrightnessOf(context);
        mode = brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
      }

      var theme = Theme.of(context, shadowThemeOnly: true);
      theme ??= mode == ThemeMode.light ? ThemeData.light() : ThemeData.dark();

      if (mode == ThemeMode.light && light != null) {
        theme = light(theme);
      } else if (mode == ThemeMode.dark && dark != null) {
        theme = dark(theme);
      }

      return AnimatedTheme(
        data: theme,
        child: child,
      );
    });
  }
}
