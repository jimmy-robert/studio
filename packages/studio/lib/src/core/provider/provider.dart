import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

import 'provided.dart';
import 'resolver.dart';

class Provider<T extends Provided> extends StatelessWidget {
  final T Function() create;

  final Widget child;

  final bool lazy;

  const Provider(this.create, {this.lazy, this.child}) : assert(create != null);

  const factory Provider.value({T value, Widget child}) = _ProviderValue;

  @override
  Widget build(BuildContext context) {
    return provider.Provider<T>(
      create: (context) {
        final value = create();
        return value
          ..resolver = _ContextResolver(context)
          ..onCreate();
      },
      dispose: (context, value) {
        value
          ..onDispose()
          ..resolver = null;
      },
      lazy: lazy,
      child: child,
    );
  }

  Provider<T> copyWith(Widget child) {
    return Provider<T>(create, lazy: lazy, child: child);
  }
}

class _ProviderValue<T extends Provided> extends Provider<T> {
  final T value;

  const _ProviderValue({this.value, Widget child}) : super(null, child: child);

  @override
  Widget build(BuildContext context) {
    return provider.Provider<T>.value(value: value, child: child);
  }

  @override
  Provider<T> copyWith(Widget child) {
    return _ProviderValue<T>(value: value, child: child);
  }
}

class _ContextResolver extends Resolver {
  final BuildContext context;

  _ContextResolver(this.context);

  @override
  T resolve<T extends Provided>({bool allowNull = true}) {
    try {
      return provider.Provider.of<T>(context, listen: false);
    } on provider.ProviderNotFoundException {
      if (!allowNull) rethrow;
      return null;
    }
  }
}
