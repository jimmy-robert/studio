import 'package:flutter/material.dart';
import 'package:studio/src/core/dependencies/dependency.dart';
import 'package:studio/src/core/navigation/screen_router.dart';
import 'package:studio/src/core/navigation/screen_routes.dart';
import 'package:studio/src/core/serializer/serialization_scope.dart';
import 'package:studio/src/widgets/restart_widget.dart';
import 'package:studio/studio.dart';

final _expando = Expando<_AppState>();

abstract class App extends StatefulWidget {
  _AppState get _state => _expando[this]!;

  final module = Module();

  @override
  _AppState createState() => _AppState();

  @mustCallSuper
  void onCreate() {
    module
      ..clear()
      ..dependency(() => SerializationScope())
      ..dependency(() => NumSerializer())
      ..dependency(() => IntSerializer())
      ..dependency(() => DoubleSerializer())
      ..dependency(() => StringSerializer())
      ..dependency(() => BoolSerializer())
      ..dependency(() => ScreenRoutes(shouldMergeRoutes: false));
  }

  Widget build(BuildContext context);

  void run() => runApp(this);

  void restart() => _state.restart();

  Widget buildApp(BuildContext context, Widget child) => child;
}

class _AppState extends State<App> {
  final _restartKey = GlobalKey<RestartWidgetState>();
  late final App _initialWidget;

  @override
  void initState() {
    super.initState();

    _initialWidget = widget;
    _expando[widget] = this;

    widget.onCreate();
  }

  @override
  void dispose() {
    _expando[widget] = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dependency<App>.value(
      value: _initialWidget,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          final app = RestartWidget(
            key: _restartKey,
            child: Module.fromModule(
              module: _initialWidget.module,
              child: Builder(builder: _initialWidget.build),
            ),
          );

          return _initialWidget.buildApp(context, app);
        },
      ),
    );
  }

  void restart() => _restartKey.currentState?.restart();
}
