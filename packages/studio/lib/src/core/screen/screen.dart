import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:studio/src/core/screen/screen_controller.dart';
import 'package:studio/studio.dart';

abstract class Screen<T extends ScreenController> extends Widget {
  @override
  Element createElement() => _ScreenElement<T>(this);

  Widget build(T controller);
}

class _ScreenElement<T extends ScreenController> extends ComponentElement {
  _ScreenElement(Screen widget) : super(widget);

  @override
  Screen get widget => super.widget as Screen;

  @override
  Widget build() {
    var controller = Dependency.maybeResolve<T>(this);
    if (controller != null) return widget.build(controller);

    final factory = Dependency.resolve<Factory<T>>(this);
    return Dependency<T>(
      create: () => factory.constructor(),
      child: Builder(
        builder: (context) {
          final controller = Dependency.resolve<T>(context);
          return widget.build(controller);
        },
      ),
    );
  }
}
