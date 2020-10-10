import 'package:flutter/material.dart';

import '../injection/provider.dart';
import '../reactive/rx.dart';
import 'platform_controller.dart';
import 'theme_controller.dart';

class ThemeBuilder extends StatelessWidget {
  final Widget child;

  const ThemeBuilder({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Rx.builder(
      builder: (context) {
        final themeController = context.resolve<ThemeController>();
        final platformController = context.resolve<PlatformController>();

        var theme = Theme.of(context, shadowThemeOnly: true) ?? ThemeData.fallback();
        final platform = platformController.platform.value ?? theme.platform;
        final dark = themeController.dark.value;
        final light = themeController.light.value;
        var mode = themeController.mode.value;

        if (mode == null || mode == ThemeMode.system) {
          final brightness = MediaQuery.platformBrightnessOf(context);
          mode = brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
        }

        if (mode == ThemeMode.dark && dark != null) {
          theme = dark;
        } else if (mode == ThemeMode.light && light != null) {
          theme = light;
        } else {
          theme = light ?? dark ?? theme;
        }

        return Theme(
          data: theme.copyWith(platform: platform),
          child: child,
        );
      },
    );
  }
}
