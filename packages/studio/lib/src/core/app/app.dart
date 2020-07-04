import 'package:flutter/material.dart';

import '../../widgets/init_widget.dart';
import '../../widgets/wrapper.dart';
import '../provider/module.dart';
import '../provider/provider.dart';
import '../theme/theme_builder.dart';
import '../theme/theme_mode_controller.dart';
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

  void run() {
    runApp(this);
  }

  Widget wrapAppController(BuildContext context, Widget child) {
    return child;
  }

  Widget wrapApp(BuildContext context, Widget child) {
    return child;
  }
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
            child: InitWidget(
              onInit: widget.onCreate,
              child: Builder(
                builder: (context) {
                  return ModuleWidget(
                    module: Module() //
                      ..add(Provider(() => ThemeModeController()))
                      ..addModule(context.get<Module>()),
                    child: InitWidget(
                      onInit: widget.onReady,
                      child: MaterialApp(
                        debugShowCheckedModeBanner: false,
                        navigatorKey: context.get<AppController>().navigatorKey,
                        initialRoute: '/',
                        routes: {'/': widget.build},
                        builder: (context, child) {
                          child = ThemeBuilder(child: child);
                          child = Wrapper(builder: widget.wrapApp, child: child);
                          return child;
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
