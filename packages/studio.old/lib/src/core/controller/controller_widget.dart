import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../injection/provider.dart';
import 'controller.dart';

abstract class ControllerWidget<T extends Controller> extends StatefulWidget {
  @override
  _ControllerWidgetState<T> createState() => _ControllerWidgetState<T>();

  Widget build(BuildContext context, T controller);
}

class _ControllerWidgetState<T extends Controller> extends State<ControllerWidget<T>> {
  @override
  Widget build(BuildContext context) {
    final controller = context.resolve<T>();
    if (controller != null) {
      return widget.build(context, controller);
    }

    final controllerFactory = context.resolve<Factory<T>>();
    if (controllerFactory != null) {
      return Provider<T>(
        controllerFactory.constructor,
        child: Builder(
          builder: (context) => widget.build(context, context.resolve<T>()),
        ),
      );
    }

    throw Exception('Could not find provider or factory for controller of type $T');
  }
}
