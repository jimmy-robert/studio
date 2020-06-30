import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

import '../lifecycle/lifecycle.dart';
import '../resolver/proxy.dart';
import '../resolver/resolver.dart';

class Provider<T> extends StatelessWidget {
  final T Function() create;

  final Widget child;

  final bool lazy;

  final bool factory;

  const Provider._(this.create, {this.lazy, this.factory, this.child});

  const Provider(this.create, {this.lazy, this.child}) : factory = false;

  const Provider.factory(this.create, {this.lazy, this.child}) : factory = true;

  const factory Provider.value(T value, {Widget child}) = _ProviderValue<T>;

  @override
  Widget build(BuildContext context) {
    return provider.Provider<_Provider<T>>(
      create: (context) {
        final _provider = _Provider<T>(context: context, create: create, lazy: lazy, factory: factory);
        if (!factory) {
          final value = _provider.value = _provider.create();

          if (value is Proxy) value.resolver = _ContextResolver(context);
          if (value is Lifecycle) value.onCreate();
        }
        return _provider;
      },
      dispose: (context, provider) {
        final value = provider.value;

        if (value is Lifecycle) value.onDispose();
        if (value is Proxy) value.resolver = null;

        provider.value = null;
        provider.context = null;
      },
      lazy: lazy,
      child: child,
    );
  }

  Provider<T> copyWith(Widget child) {
    return Provider<T>._(create, lazy: lazy, factory: factory, child: child);
  }
}

class _ProviderValue<T> extends Provider<T> {
  final T value;

  const _ProviderValue(this.value, {Widget child}) : super._(null, child: child);

  @override
  Widget build(BuildContext context) {
    return provider.Provider<T>.value(value: value, child: child);
  }

  @override
  Provider<T> copyWith(Widget child) {
    return _ProviderValue<T>(value, child: child);
  }
}

class _Provider<T> {
  BuildContext context;

  T value;

  final T Function() create;

  final bool lazy;

  final bool factory;

  _Provider({this.context, this.create, this.lazy, this.factory});
}

extension ContextProviderExtension on BuildContext {
  T get<T>({bool allowNull = true}) {
    try {
      final _provider = provider.Provider.of<_Provider<T>>(this, listen: false);

      // Single instance
      if (!_provider.factory) return _provider.value;

      // Factory
      final value = _provider.create();
      if (value is Lifecycle) value.onCreate();

      return value;
    } on provider.ProviderNotFoundException {
      if (allowNull) return null;
      rethrow;
    }
  }
}

class _ContextResolver with Resolver {
  final BuildContext context;
  const _ContextResolver(this.context);

  @override
  T get<T>({bool allowNull = true}) => context.get(allowNull: allowNull);
}
