import 'package:flutter/material.dart';

import 'provider.dart';

class Module extends StatelessWidget {
  final List<Provider> providers;
  final Widget child;

  Module({
    Key key,
    @required this.providers,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var child = this.child;
    for (final provider in providers.reversed) {
      child = provider.copyWith(child);
    }
    return child;
  }
}
