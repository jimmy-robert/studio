import 'package:flutter/material.dart';

import '../injection/provider.dart';
import 'controller.dart';

abstract class ControllerWidget<T extends Controller> extends Widget {
  ControllerWidget({Key key}) : super(key: key);

  @override
  Element createElement() => _ControllerWidgetElement<T>(this);

  T createController();

  Widget build(BuildContext context, T controller);
}

class _ControllerWidgetElement<T extends Controller> extends ComponentElement {
  @override
  ControllerWidget<T> get widget => super.widget as ControllerWidget<T>;

  _ControllerWidgetElement(ControllerWidget<T> widget) : super(widget);

  @override
  Widget build() {
    final controller = resolve<T>();
    if (controller != null) {
      return widget.build(this, controller);
    }
    return Provider<T>(
      widget.createController,
      child: Builder(
        builder: (context) => widget.build(context, context.resolve<T>()),
      ),
    );
  }

  @override
  void update(Widget newWidget) {
    super.update(newWidget);
    markNeedsBuild();
  }
}
