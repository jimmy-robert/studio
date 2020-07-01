import 'package:flutter/material.dart';

import '../provider/module.dart';
import '../provider/provider.dart';
import '../reactive/observer.dart';
import 'app_theme.dart';

abstract class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();

  @mustCallSuper
  void onCreate(BuildContext context) {}

  @mustCallSuper
  void onReady(BuildContext context) {}

  Widget build(BuildContext context);

  void run() {
    runApp(_AppRunner(child: this));
  }
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    widget.onCreate(context);
  }

  @override
  Widget build(BuildContext context) {
    return ModuleWidget(
      module: context.get<Module>(),
      child: _AppReady(
        onReady: widget.onReady,
        child: Builder(
          builder: (context) {
            final app = MaterialApp(
              initialRoute: '/',
              routes: {'/': widget.build},
              builder: (context, child) {
                child = _AppTheme(child: child);
                return child; // todo: use wrappers/builders
              },
            );

            return app; // todo: use wrappers/builders
          },
        ),
      ),
    );
  }
}

class _AppRunner extends StatelessWidget {
  final Widget child;

  const _AppRunner({@required this.child});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context, nullOk: true) ?? MediaQueryData.fromWindow(WidgetsBinding.instance.window),
      child: ModuleWidget(
        module: Module() //
          ..add(Provider(() => GlobalKey())) // todo Studio Trojan State
          ..add(Provider(() => Module()))
          ..add(Provider(() => AppTheme())),
        child: child,
      ),
    );
  }
}

class _AppReady extends StatefulWidget {
  final void Function(BuildContext context) onReady;
  final Widget child;

  const _AppReady({@required this.onReady, @required this.child});

  @override
  _AppReadyState createState() => _AppReadyState();
}

class _AppReadyState extends State<_AppReady> {
  @override
  void initState() {
    super.initState();
    widget.onReady(context);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _AppTheme extends StatelessWidget {
  final Widget child;

  const _AppTheme({this.child});

  @override
  Widget build(BuildContext context) {
    return Observer(() {
      final theme = _resolveTheme(context);
      return AnimatedTheme(data: theme, child: child);
    });
  }

  static ThemeData _resolveTheme(BuildContext context) {
    final appTheme = context.get<AppTheme>();

    final light = appTheme.light.value;
    final dark = appTheme.dark.value;
    final mode = appTheme.mode.value;

    if (mode == ThemeMode.dark) return dark;
    if (mode == ThemeMode.light) return light;

    final brightness = MediaQuery.platformBrightnessOf(context);
    if (brightness == Brightness.dark) return dark;

    return light;
  }
}
