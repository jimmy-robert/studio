import 'package:flutter/material.dart';

import '../../widgets/rerun_widget.dart';
import '../provider/provider.dart';

mixin AppController {
  GlobalKey<NavigatorState> get navigatorKey;

  void restart();

  void rerun();
}

class AppControllerWidget extends StatefulWidget {
  final Widget child;

  const AppControllerWidget({@required this.child});

  @override
  _AppControllerWidgetState createState() => _AppControllerWidgetState();
}

class _AppControllerWidgetState extends State<AppControllerWidget> with AppController, SingleTickerProviderStateMixin {
  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  var _session = DateTime.now();
  DateTime get session => _session;

  final _rerunKey = GlobalKey<RerunWidgetState>();

  @override
  Widget build(BuildContext context) {
    return RerunWidget(
      key: _rerunKey,
      child: Provider<AppController>.value(this, child: widget.child),
    );
  }

  @override
  void rerun() {
    _session = DateTime.now();
    _rerunKey.currentState.rerun();
  }

  @override
  void restart() {
    navigatorKey.currentState.pushNamedAndRemoveUntil('/', (route) => false);
  }
}
