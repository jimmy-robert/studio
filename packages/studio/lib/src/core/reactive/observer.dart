import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart' as flutter_mobx;

class Observer extends StatelessWidget {
  final Widget Function() builder;

  const Observer(this.builder);

  const factory Observer.withContext(WidgetBuilder builder) = _ContextObserver;

  @override
  Widget build(BuildContext context) {
    return flutter_mobx.Observer(builder: (context) => builder());
  }
}

class _ContextObserver extends Observer {
  final WidgetBuilder widgetBuilder;

  const _ContextObserver(this.widgetBuilder) : super(null);

  @override
  Widget build(BuildContext context) {
    return flutter_mobx.Observer(builder: (context) => widgetBuilder(context));
  }
}
