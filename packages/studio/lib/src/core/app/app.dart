import 'package:flutter/material.dart';
import 'package:studio/studio.dart';

import '../../widgets/init_widget.dart';
import '../../widgets/wrapper.dart';
import '../injection/module.dart';
import '../injection/provider.dart';
import '../theme/theme_builder.dart';
import '../theme/theme_controller.dart';
import 'app_controller.dart';

abstract class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();

  @mustCallSuper
  void onCreate(BuildContext context) {}

  @mustCallSuper
  void onReady(BuildContext context) {}

  Widget build(BuildContext context);

  void run() => runApp(this);

  Widget wrapAppController(BuildContext context, Widget child) => child;

  Widget wrapApp(BuildContext context, Widget child) => child;
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context, nullOk: true) ?? MediaQueryData.fromWindow(WidgetsBinding.instance.window),
      child: Wrapper(
        builder: widget.wrapAppController,
        child: AppControllerWidget(
          child: Provider(
            () => Module(),
            child: Provider(
              () => ThemeController(),
              child: Provider(
                () => PlatformController(),
                child: InitWidget(
                  onInit: widget.onCreate,
                  child: ModuleBuilder(
                    builder: (context) => Module()..addModule(context.get<Module>()),
                    child: InitWidget(
                      onInit: widget.onReady,
                      child: _App(
                        builder: widget.build,
                        wrapApp: widget.wrapApp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _App extends StatelessWidget {
  final WidgetBuilder builder;
  final Widget Function(BuildContext, Widget) wrapApp;

  const _App({
    @required this.builder,
    @required this.wrapApp,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: context.get<AppController>().navigatorKey,
      initialRoute: '/',
      routes: {'/': builder},
      builder: (context, child) {
        child = Wrapper(builder: wrapApp, child: child);
        child = ThemeBuilder(child: child);
        return child;
      },
    );
  }
}
