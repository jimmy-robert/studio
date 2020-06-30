import 'package:flutter/material.dart';

import 'provider.dart';

class Module {
  final _providers = <Provider>[];
  void add<T>(Provider<T> provider) => _providers.add(provider);
  void addModule(Module module) => _providers.addAll(module._providers);
}

class ModuleWidget extends StatelessWidget {
  final Module module;
  final Widget child;

  ModuleWidget({
    Key key,
    @required this.module,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var child = this.child;
    for (final provider in module._providers.reversed) {
      child = provider.copyWith(child);
    }
    return child;
  }
}
