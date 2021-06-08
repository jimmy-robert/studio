import 'package:flutter/material.dart';
import 'package:studio/src/core/reactive/observable.dart';

class Observer extends StatelessWidget {
  final Observable observable;
  final Widget Function() builder;

  Observer({
    required this.observable,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: observable.stream,
      builder: (context, value) => builder(),
    );
  }
}
