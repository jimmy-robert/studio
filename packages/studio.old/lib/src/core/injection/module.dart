import 'package:flutter/material.dart';

import 'provider.dart';

class Module {
  final _providers = <Provider>[];
  void add<T>(Provider<T> provider) => _providers.add(provider);
  void addAll(List<Provider> provider) => _providers.addAll(provider);
  void addModule(Module module) => _providers.addAll(module._providers);
}

class ModuleBuilder extends StatefulWidget {
  final Module Function(BuildContext module) builder;
  final Widget child;

  const ModuleBuilder({@required this.builder, @required this.child});

  @override
  _ModuleBuilderState createState() => _ModuleBuilderState();
}

class _ModuleBuilderState extends State<ModuleBuilder> {
  Module module;

  @override
  void initState() {
    super.initState();
    module = widget.builder(context);
  }

  @override
  Widget build(BuildContext context) {
    var child = widget.child;
    for (final provider in module._providers.reversed) {
      child = provider.copyWith(child);
    }
    return child;
  }
}
