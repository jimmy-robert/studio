import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  final Widget Function(BuildContext context, Widget child) builder;
  final Widget child;

  const Wrapper({
    @required this.builder,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) => builder(context, child);
}
