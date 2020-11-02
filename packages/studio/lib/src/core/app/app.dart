import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../widgets/init_widget.dart';
import '../../widgets/rerun_widget.dart';
import '../../widgets/wrapper.dart';
import '../injection/module.dart';
import '../injection/provider.dart';
import '../network/http_service.dart';
import '../serializer/serializer.dart';
import '../theme/platform_controller.dart';
import '../theme/theme_builder.dart';
import '../theme/theme_controller.dart';

final _expando = Expando<_AppState>();

abstract class App extends StatefulWidget {
  _AppState get _state => _expando[this];

  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();

  @mustCallSuper
  void onCreate() {}

  @mustCallSuper
  void onReady() {}

  Widget build(BuildContext context);

  Widget buildApp(BuildContext context, Widget child) => child;

  void run() => runApp(this);

  void register<T>(T Function() provider, {bool lazy = false, bool factory = false}) {
    final module = _state._currentAppContext.resolve<Module>();

    if (factory) {
      module.add(Provider<Factory<T>>(() => Factory<T>(provider), lazy: lazy));
    } else {
      module.add(Provider<T>(provider, lazy: lazy));
    }
  }

  T resolve<T>() => _state._currentAppContext.resolve<T>();

  void restart() => _state.restart();

  void rerun() => _state.rerun();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  DateTime _session;
  DateTime get session => _session;

  final _rerunKey = GlobalKey<RerunWidgetState>();

  App _initialWidget;

  BuildContext _currentAppContext;

  @override
  void initState() {
    super.initState();
    _session = DateTime.now();
    _initialWidget = widget;
    _expando[widget] = this;
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.maybeOf(context) ?? MediaQueryData.fromWindow(WidgetsBinding.instance.window),
      child: Provider<App>.value(
        _initialWidget,
        child: RerunWidget(
          key: _rerunKey,
          child: ModuleBuilder(
            builder: (context) {
              // Default module
              return Module()
                ..add(Provider(() => HttpService()))
                ..add(Provider(() => DefaultSerializer()))
                ..add(Provider(() => ThemeController()))
                ..add(Provider(() => PlatformController()));
            },
            child: Provider(
              () => Module(),
              child: InitWidget(
                onInit: (context) {
                  _currentAppContext = context;
                  _initialWidget.onCreate();
                  _currentAppContext = null;
                },
                child: ModuleBuilder(
                  builder: (context) => Module()..addModule(context.resolve<Module>()),
                  child: InitWidget(
                    onInit: (context) {
                      _currentAppContext = context;
                      _initialWidget.onReady();
                      _currentAppContext = null;
                    },
                    child: _App(
                      navigatorKey: _navigatorKey,
                      builder: _initialWidget.build,
                      appBuilder: _initialWidget.buildApp,
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

  void rerun() {
    _session = DateTime.now();
    _rerunKey.currentState.rerun();
  }

  void restart() {
    _navigatorKey.currentState.pushNamedAndRemoveUntil('/', (route) => false);
  }
}

class _App extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final WidgetBuilder builder;
  final Widget Function(BuildContext, Widget) appBuilder;

  const _App({
    @required this.navigatorKey,
    @required this.builder,
    @required this.appBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {'/': builder},
      builder: (context, child) {
        return ThemeBuilder(
          child: Wrapper(
            builder: appBuilder,
            child: child,
          ),
        );
      },
    );
  }
}
